import SwiftUI
import RealityKit
import ARKit
import FocusEntity
import Combine

struct ARExperienceView: View {
    @State private var modelEntities: [ModelEntity] = []
    @State private var selectedModelName: String? = nil
    @State private var arCoordinator: ARContainerView.Coordinator?
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            ZStack {
                ARContainerView(selectedModelName: $selectedModelName, modelEntities: $modelEntities)
                
                VStack {
                    Text("View Clothes")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.top, 62)
                    
                    HStack {
                        
                        Spacer()
                        
                        VStack(spacing: 14) {
                            Button {

                            } label: {
                                Image(systemName: "pencil")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.white)
                                    .padding(10)
                                    .background(Color.clear)
                                    .contentShape(Rectangle())
                            }
                        }
                        .padding()
                    }
                    
                    Spacer()
                    BottomSheet(selectedModelName: $selectedModelName)
                }
            }
            .navigationBarTitle(Text(""), displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "arrow.left")
                    .foregroundColor(.white)
                    .font(.title2)
                    .padding()
            })
            .edgesIgnoringSafeArea([.top, .bottom])
        }
    }
}

struct ARContainerView: UIViewRepresentable {
    @Binding var selectedModelName: String?
    @Binding var modelEntities: [ModelEntity]

    func makeUIView(context: Context) -> ARView {
        let view = ARView()
        
        let session = view.session
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal]
        session.run(config)
        
        let coachingOverlay = ARCoachingOverlayView()
        coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        coachingOverlay.session = session
        coachingOverlay.goal = .horizontalPlane
        view.addSubview(coachingOverlay)
        
        context.coordinator.view = view
        session.delegate = context.coordinator
        
        view.addGestureRecognizer(
            UITapGestureRecognizer(
                target: context.coordinator,
                action: #selector(Coordinator.handleTap)
            )
        )
        
        return view
    }

    func updateUIView(_ uiView: ARView, context: Context) {

    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(selectedModelName: $selectedModelName)
    }

    class Coordinator: NSObject, ARSessionDelegate {
        weak var view: ARView?
        var selectedModelName: Binding<String?>
        var focusEntity: FocusEntity?
        var addedAnchors: [AnchorEntity] = []
        
        init(selectedModelName: Binding<String?>) {
            self.selectedModelName = selectedModelName
            
            super.init()
        }

        func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
            guard let view = self.view else { return }

            if self.focusEntity == nil {
                self.focusEntity = FocusEntity(on: view, style: .classic(color: .yellow))
            } else {
            }
        }
        
        @objc func handleTap(gesture: UITapGestureRecognizer) {
            guard let view = self.view, let focusEntity = self.focusEntity else { return }

            if let modelName = selectedModelName.wrappedValue {
                let anchor = AnchorEntity()
                view.scene.anchors.append(anchor)

                let modelEntity = try! ModelEntity.loadModel(named: modelName)
                modelEntity.scale = [0.01, 0.01, 0.01]
                modelEntity.position = focusEntity.position
                modelEntity.generateCollisionShapes(recursive: true)
                view.installGestures([.all], for: modelEntity)

                anchor.addChild(modelEntity)

                addedAnchors.append(anchor)
            }
        }
    }
}

struct BottomSheet: View {
    @Binding var selectedModelName: String?
    @State private var showBiddingView: Bool = false

    var body: some View {
        VStack {
            HStack {
                Text("My Collection")
                    .font(.system(size: 25)).bold()
                    .foregroundColor(.white)
                    .padding(.leading, 24)
                    .padding(.top, 12)
                
                Spacer()
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(clothes) { cloth in
                        VStack {
                            Image(cloth.imageUrl)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .cornerRadius(12)

                                .onTapGesture {
                                    selectedModelName = cloth.model
                                }
                        }
                        .sheet(isPresented: $showBiddingView) {
                        }
                    }
                }
            }
            .padding()
            .offset(y: -10)
            .padding(.bottom, 14)
        }
        .background(BlurView())
        .cornerRadius(18)
    }
}

struct BlurView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}

struct ARExperienceView_Previews: PreviewProvider {
    static var previews: some View {
        ARExperienceView()
    }
}

