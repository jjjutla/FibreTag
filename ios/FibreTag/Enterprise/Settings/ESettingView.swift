import SwiftUI

struct ESettingView: View {
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                HStack(spacing: 14) {
                    Image("profilepic")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading) {
                        Text("Vechain Representative")
                            .font(.system(size: 19)).bold()
                        
                        Text("rep@vechain.com")
                            .font(.caption)
                    }
                                        
                    Spacer()
                }
                
                Text("FibreTag member since November 2023")
                    .padding(.vertical, 8)
                
                Button {
                    UserDefaults.standard.set(false, forKey: "signin")
                } label: {
                    HStack(spacing: 12) {
                        Text("Contact FibreTag")
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
                    .padding(.top, 20)
                    .padding(.bottom, 10)
                }
                
                Button {
                    UserDefaults.standard.set(false, forKey: "signin")
                } label: {
                    HStack(spacing: 12) {
                        Text("Sign Out")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundStyle(.white)
                    }
                    .hCenter()
                    .padding(.leading, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 14)
                            .fill(.red)
                            .frame(height: 50)
                    )
                    .padding(.top, 20)
                }
                
                Spacer()
            }
            .padding(.horizontal, 16)
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    ESettingView()
}
