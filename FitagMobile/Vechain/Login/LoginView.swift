//
//  LoginScreen.swift
//  Vechain
//
//  Created by Artemiy Malyshau on 07/10/2023.
//

import SwiftUI
import GoogleSignIn
import FirebaseAuth
import Firebase

struct LoginView: View {
    
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
                    
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 70)
                        .padding(.top, 40)
                        .padding(.bottom, 60)
                    
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

                        // Create Google Sign In configuration object.
                        let config = GIDConfiguration(clientID: clientID)
                        GIDSignIn.sharedInstance.configuration = config

                        // Start the sign in flow!
                        GIDSignIn.sharedInstance.signIn(withPresenting: getRootViewController()) { result, error in
                          guard error == nil else {
                            // ...
                              return
                          }

                          guard let user = result?.user,
                            let idToken = user.idToken?.tokenString
                          else {
                            // ...
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
                                .font(.system(size: 18, weight: .bold))
                                .foregroundStyle(.black)
                        }
                        .hCenter()
                        .padding(.leading, 10)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.white.opacity(0.7))
                                .frame(height: 50)
                        )
                    }
                    .padding(.top, 24)
                    .padding(.horizontal, 16)
                    
                    
                    Button {
                        
                    } label: {
                        HStack(spacing: 12) {
                            Image("Apple")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 30)
                                .offset(y: -2)
                            
                            Text("Sign in with Apple")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundStyle(.black)
                        }
                        .hCenter()
                        .padding(.leading, 10)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.white.opacity(0.7))
                                .frame(height: 50)
                        )
                    }
                    .padding(.top, 20)
                    .padding(.horizontal, 16)
                    
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
                    
                    Spacer()
                    
                    NavigationLink {
                        TabBarView()
                    } label: {
                        HStack(spacing: 12) {
                            Text("Login")
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
                        .padding(.top, 20)
                        .padding(.horizontal, 16)
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

extension View {
    
    func hLeading() -> some View {
        self
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func hTrailing() -> some View {
        self
            .frame(maxWidth: .infinity, alignment: .trailing)
    }
    
    func hCenter() -> some View {
        self
            .frame(maxWidth: .infinity, alignment: .center)
    }

}

extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}
