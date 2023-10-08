import SwiftUI
import SwiftNFC

struct ScannerView: View {
    @ObservedObject var NFCR = NFCReader()
    @State private var scanned: Bool = false
    @State private var showFoundView: Bool = false

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [.green.opacity(0.2), .white]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .edgesIgnoringSafeArea(.all)
                
                VStack {
                    if !scanned {
                        ContentUnavailableView(label: {
                            Label("Detect your NFC Tags", systemImage: "wifi")
                                .symbolEffect(.pulse, options: .repeating)
                        }, description: {
                            Text("Start adding expenses to see your list.")
                        }, actions: {
                            Button("Begin Search") {
                                NFCR.read()
                                scanned.toggle()
                            }
                        })
                        .offset(y: -60)
                    } else {
                        VStack(spacing: 20) {
                            
                            TextEditor(text: $NFCR.msg)
                                .font(.headline)
                                .padding()
                                .frame(height: 100)
                                .background(Color.white)
                                .padding()
                                .cornerRadius(12)
                            
                            Button {
                                showFoundView.toggle()
                            } label: {
                                HStack(spacing: 12) {
                                    Text("Show Fitag History")
                                        .font(.system(size: 18, weight: .bold))
                                        .foregroundStyle(.white)
                                }
                                .hCenter()
                                .padding(.leading, 10)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(.blue.opacity(0.8))
                                        .frame(height: 50)
                                )
                            }
                            .padding(.horizontal, 16)
                            .sheet(isPresented: $showFoundView) {
                                NFCFoundView(clothes: nfcClothes[0])
                            }
                            
                            Spacer()
                        }
                    }
                }
            }
            .navigationTitle("Scan your Tag")
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Image(systemName: "info.circle")
                }
            }
        }
    }
}


#Preview {
    ScannerView()
}
