import SwiftUI

struct AuthView: View {
    
    @ObservedObject var authViewModel = AuthViewModel()
//    @EnvironmentObject var chatViewModel: ChatViewModel
    @State var scrollY : CGFloat = 0
    
    var body: some View {
        ScrollView {
            GeometryReader { reader in
                let minY = reader.frame(in: .named("scroll")).minY
                Color.clear.preference(key:
                    scrollPref.self, value: minY)
            }
            Group{
                
                HStack(alignment: .center) {
                    Image("seedswipe")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 50)
                }
                .padding(.bottom, 30)
                
                if authViewModel.showSignInCard {
                    SignupCard(authViewModel: authViewModel)
                }
                else {
                    if authViewModel.verificationPage {
                        VerificationView(authViewModel: authViewModel)
                    } else {
                        SigninCard(authViewModel: authViewModel)
                    }
                }
                
            }
        }
        .padding(.top, 40)
        .coordinateSpace(name: "scroll")
        .onPreferenceChange(scrollPref.self, perform: { value in
                scrollY = value
        })
        .background(
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .scaleEffect(1 + abs(scrollY/1000))
                .ignoresSafeArea()
                .brightness(-0.1)
        )
        .fullScreenCover(isPresented: $authViewModel.exitAuthPage) {
            TabBarView()
//                .environmentObject(chatViewModel)
        }
    }
}

#Preview {
    AuthView()
        .preferredColorScheme(.dark)
}
