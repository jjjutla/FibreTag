import SwiftUI

struct ScannerView: View {
    @ObservedObject var NFCR = NFCReader()
    @State private var message: String = "Initial Message"
    @State private var scanned: Bool = false
    @State private var showFoundView: Bool = false
    
    init() {
        UITextView.appearance().backgroundColor = .clear
    }

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [.white, .green.opacity(0.2)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    
                    VStack {
                        TextEditor(text: $NFCR.msg)
                            .frame(height: 80)
                            .padding(2)
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
//                            .background(.white)
                            .stroke(Color.black, lineWidth: 2)
                        )
                    .padding(.top, 10)
                    .padding(.bottom, 40)
                    
                    Button {
                        showFoundView.toggle()
                    } label: {
                        HStack(spacing: 12) {
                            Text("Verify FibreTag")
                                .font(.system(size: 18, weight: .semibold))
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
                    .sheet(isPresented: $showFoundView) {
                        NFCFoundView(clothes: arClothes[0])
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 16)
            }
            .navigationTitle("Scan FibreTag")
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Image(systemName: "info.circle")
                }
            }
            .onAppear {
                NFCR.read()
            }
        }
    }
}


#Preview {
    ScannerView()
}
