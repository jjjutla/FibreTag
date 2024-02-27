import SwiftUI
import GoogleSignIn
import FirebaseAuth
import Firebase

struct LoginView: View {
    
    @State private var isEnterprise: Bool = false
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                
                Image("bg-bright")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack {
                    
                    Image("FibreTag")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 120)
                        .cornerRadius(28)
                        .padding(.top, 40)
                    
                    Text(isEnterprise ? "FibreTag Enterprise" : "FibreTag")
                        .fontWeight(.semibold)
                        .padding(.top, 10)
                        .padding(.bottom, 50)
                        .transition(.opacity)
                        .animation(.easeInOut, value: isEnterprise)
                    
                    TextField("E-mail address", text: $email)
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(
                                    Color.black.opacity(0.04)
                                )
                        }
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(
                                    Color.black.opacity(0.04)
                                )
                        }
                        .textInputAutocapitalization(.never)
                        .padding(.top, 2)
                        .padding(.bottom, 20)
                    
                    Divider()
                        .padding(.vertical, 0)
                    
                    Button {
                        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

                        let config = GIDConfiguration(clientID: clientID)
                        GIDSignIn.sharedInstance.configuration = config

                        GIDSignIn.sharedInstance.signIn(withPresenting: getRootViewController()) { result, error in
                          guard error == nil else {
                              return
                          }

                          guard let user = result?.user,
                            let idToken = user.idToken?.tokenString
                          else {
                              return
                          }

                          let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)

                            Auth.auth().signIn(with: credential) { result, error in

                                guard error == nil else {
                                    return
                                }
                                
                                print("Signed in")
                                UserDefaults.standard.set(true, forKey: "signin")
                            }
                        }
                    } label: {
                        HStack(spacing: 12) {
                            Image("Google")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 30)
                            
                            Text("Sign in with Google")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundStyle(.black)
                        }
                        .hCenter()
                        .padding(.leading, 10)
                        .background(
                            RoundedRectangle(cornerRadius: 14)
                                .fill(.white.opacity(0.7))
                                .frame(height: 50)
                        )
                    }
                    .padding(.top, 24)
                    
                    
                    Button {
                        
                    } label: {
                        HStack {
                            Text("Don't have an account?")
                                .font(.caption)
                                .foregroundColor(.black.opacity(0.60))
                            
                            Text("Sign Up")                        .font(.caption)
                                .foregroundColor(.blue)
                            
                        }
                    }
                    .hCenter()
                    .padding(.top, 20)
                    .padding(.leading, 4)
                    
                    Button {
                        isEnterprise.toggle()
                        UserDefaults.standard.set(isEnterprise, forKey: "enterprise")
                        print(isEnterprise)
                    } label: {
                        HStack {
                            Text("Are you a partnering enterprise?")
                                .font(.caption)
                                .foregroundColor(.black.opacity(0.60))
                            
                            Text("Tap here")                        .font(.caption)
                                .foregroundColor(.blue)
                            
                        }
                    }
                    .hCenter()
                    .padding(.leading, 4)
                    
                    Spacer()
                    
                    Button {
                        UserDefaults.standard.set(true, forKey: "signin")
                    } label: {
                        HStack(spacing: 12) {
                            Text("Login")
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
                    }
                    
                    Text("By continuing, you agree to our User Agreement and Privacy Policy.")
                        .font(.caption)
                        .foregroundColor(.black.opacity(0.60))
                        .hCenter()
                        .padding(.top, 20)
                        .padding(.leading, 4)
                    
                    Spacer()
                }
                .padding(.top, 100)
                .padding(.horizontal, 16)
            }
        }
    }
}

#Preview {
    LoginView()
        .preferredColorScheme(.light)
}
