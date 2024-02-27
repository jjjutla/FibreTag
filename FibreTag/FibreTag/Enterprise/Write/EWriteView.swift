import SwiftUI

struct EWriteView: View {
    
    @ObservedObject var NFCW = NFCWriter()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Detect FibreTags (NFC Tags) and write data onto the NFC Tag")
                    .padding(.vertical, 10)
                
                Text("NFC Message")
                    .padding(.top, 10)
                    .bold()
                
                VStack {
                    TextEditor(text: $NFCW.msg)
                        .background(.red)
                        .frame(height: 80)
                        .padding(8)
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                      .stroke(Color.black, lineWidth: 2)
                    )
                .padding(.bottom, 40)
                
                Button {
                    NFCW.write()
                } label: {
                    HStack(spacing: 12) {
                        Text("Write Data")
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
                
                Spacer()
                
            }
            .padding(.horizontal, 16)
            .navigationTitle("Data")
        }
    }
}

#Preview {
    EWriteView()
}
