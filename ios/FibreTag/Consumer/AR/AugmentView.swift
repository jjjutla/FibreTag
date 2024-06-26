import SwiftUI

struct AugmentView: View {
    
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    @State private var showARExperience = false

    var body: some View {
        NavigationView {
            ZStack {
                
                LinearGradient(
                    gradient: Gradient(colors: [.green.opacity(0.2), .white]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(alignment: .leading) {
                    
                    Image("sample")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 356, height: 200)
                        .clipped()
                        .cornerRadius(10)
                        .padding(.vertical, 10)
                    
                    HStack {
                        Text("View all the NFT digital twins of the products you have purchased in Augmented Reality (AR)")
                        
                        Spacer()
                    }
                    
                    HStack {
                        Text("Your Items")
                            .font(.title2).bold()
                    }
                    .padding(.top, 10)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(arClothes) { clo in
                                AugmentMarketplaceView(clothe: clo)
                                    .containerRelativeFrame(.horizontal, count: 3, spacing: 4)
                                    .scrollTransition { content, phase in
                                        content
                                            .opacity(phase.isIdentity ? 1.0 : 0.1)
                                            .scaleEffect(x: phase.isIdentity ? 1.0 : 0.3,
                                                         y: phase.isIdentity ? 1.0 : 0.3)
                                            .offset(y: phase.isIdentity ? 0 : 50)
                                    }
                            }
                        }
                        .scrollTargetLayout()
                    }
                    .contentMargins(24, for: .scrollContent)
                    .scrollTargetBehavior(.viewAligned)
                    .hCenter()
                    .offset(x: -20, y: -24)
                    
                    Button {
                        showARExperience = true
                    } label: {
                        HStack(spacing: 12) {
                            Text("Start AR Experience")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundStyle(.white)
                        }
                        .hCenter()
                        .padding(.leading, 10)
                        .background(
                            RoundedRectangle(cornerRadius: 14)
                                .fill(.blue)
                                .frame(height: 50)
                        )
                    }
                    .offset(y: -6)
                    .fullScreenCover(isPresented: $showARExperience) {
                        ARExperienceView()
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 16)
                .navigationTitle("Augment")
                .toolbar {
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        
                    }
                }
            }
        }
    }
}

#Preview {
    AugmentView()
}
