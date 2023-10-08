import SwiftUI

struct SettingsView: View {
    @State private var privateKey: String = ""

    var body: some View {
        List {
            HStack {
                TextField("Enter Private Key", text: $privateKey)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .overlay(
                        HStack {
                            Spacer()
                            if !privateKey.isEmpty {
                                Button(action: {
                                    self.privateKey = ""
                                    savePrivateKey()
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.gray)
                                }
                                .padding(.trailing, 8)
                            }
                        }
                    )
            }
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: loadPrivateKey)
    }
    
    func savePrivateKey() {
        UserDefaults.standard.setValue(privateKey, forKey: "privateKey")
    }
    
    func loadPrivateKey() {
        if let savedKey = UserDefaults.standard.string(forKey: "privateKey") {
            privateKey = savedKey
        }
    }
}

#Preview {
    SettingsView()
}
