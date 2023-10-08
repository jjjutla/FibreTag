//
//  ContentView.swift
//  SeedSwipe
//
//  Created by Artemiy Malyshau on 18/09/2023.
//

import SwiftUI

struct SignupCard: View {
    
    @State var name = ""
    @State var email = ""
    @State var password = ""
    @State var selectedPerson = false
    @State var selectedEmail = false
    @State var selectedPass = false
    @State var animPerson = false
    @State var animEmail = false
    @State var animPass = false
    @State var showAlert = false
    @State var alertTitle = ""
    @State var alertMessage = ""
    
    @State var appear = [false, false, false]
    
    @ObservedObject var authViewModel: AuthViewModel
    
    var body: some View {
        content
            .alert(alertTitle, isPresented: $showAlert) {
                Button("Got it!") {
                    // Actions on dismiss
                }
            } message: {
                Text(alertMessage)
            }
            .scaleEffect(appear[0] ? 1 : 0.5)
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Sign up")
                .font(.largeTitle.weight(.bold))
                .foregroundColor(.white)
            Text("Gain access start-ups and investors, ready to match and conquer!")
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.6))
            nameField
            emailField
            passwordField
            
            AngularButton(title: "Create account") {
                createAccount()
            }
            .scaleEffect(x: appear[2] ? 1.0 : 1.2)
            .opacity(appear[2] ? 1 : 0)
            .onAppear{
                withAnimation(.easeInOut.delay(0.4)) {
                    appear[2] = true
                }
            }

            Text("By clicking on Sign up, you agree to our Terms of service and Privacy policy.")
                .font(.footnote)
                .foregroundColor(.white.opacity(0.6))
            Divider().background(.white.opacity(0.9))
            Button {
                withAnimation(.spring()) {
                    authViewModel.showSignInCard.toggle()
                }
            } label: {
                HStack {
                    Text("Already have an account?")
                        .font(.footnote)
                        .foregroundColor(.white.opacity(0.6))
                    Text("Sign in")
                        .font(.footnote.weight(.bold))
                        .foregroundLinearGradient()
                }
            }

        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 30, style: .continuous).stroke(.white.opacity(0.5))
                .background(.ultraThinMaterial)
                .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                //.shadow(color: Color("shadowColor"), radius: 30, y: 30)
        )
        .padding(.horizontal,20)
    }
    
    var nameField : some View {
        HStack(spacing: 12){
            AngularIcon(icon: "person.fill", selected: $selectedPerson)
                .scaleEffect(animPerson ? 1.2 : 1.0)
            TextField("Full Name", text: $email)
                .foregroundColor(.white)
                .textContentType(.emailAddress)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
            
        }
        .padding(.horizontal,8)
        .frame(height: 56)
        .background(Color("secondaryBackground").opacity(0.8), in: RoundedRectangle(cornerRadius: 16,style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 16,style: .continuous).stroke(.white.opacity(0.4))
        )
        .onTapGesture {
            withAnimation(.easeInOut) {
                selectedPerson = true
                selectedEmail = false
                selectedPass = false
            }
            withAnimation {
                animPerson = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25 ){
                withAnimation {
                    animPerson = false
                }
            }
            
        }
        .scaleEffect(x: appear[0] ? 1.0 : 1.2)
        .opacity(appear[0] ? 1 : 0)
        .onAppear{
            withAnimation(.easeInOut) {
                appear[0] = true
            }
        }
    }
    
    var emailField : some View {
        HStack(spacing: 12){
            AngularIcon(icon: "envelope.open.fill", selected: $selectedEmail)
                .scaleEffect(animEmail ? 1.2 : 1.0)
            TextField("Email Address", text: $email)
                .foregroundColor(.white)
                .textContentType(.emailAddress)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
            
        }
        .padding(.horizontal,8)
        .frame(height: 56)
        .background(Color("secondaryBackground").opacity(0.8), in: RoundedRectangle(cornerRadius: 16,style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 16,style: .continuous).stroke(.white.opacity(0.4))
        )
        .onTapGesture {
            withAnimation(.easeInOut) {
                selectedPerson = false
                selectedEmail = true
                selectedPass = false
            }
            withAnimation {
                animEmail = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25 ){
                withAnimation {
                    animEmail = false
                }
            }
            
        }
        .scaleEffect(x: appear[0] ? 1.0 : 1.2)
        .opacity(appear[0] ? 1 : 0)
        .onAppear{
            withAnimation(.easeInOut) {
                appear[0] = true
            }
        }
    }
    
    var passwordField : some View {
        HStack(spacing: 12){
            AngularIcon(icon: "key.fill", selected: $selectedPass)
                .scaleEffect(animPass ? 1.2 : 1.0)
            SecureField("Password", text: $password)
                .foregroundColor(.white)
                .textContentType(.password)
        }
        .padding(.horizontal,8)
        .frame(height: 56)
        .background(Color("secondaryBackground").opacity(0.8), in: RoundedRectangle(cornerRadius: 16,style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 16,style: .continuous).stroke(.white.opacity(0.4))
        )
        .onTapGesture {
            withAnimation(.easeInOut) {
                selectedPerson = false
                selectedEmail = false
                selectedPass = true
            }
            withAnimation {
                animPass = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25 ){
                withAnimation {
                    animPass = false
                }
            }
        }
        .scaleEffect(x: appear[1] ? 1.0 : 1.2)
        .opacity(appear[1] ? 1 : 0)
        .onAppear{
            withAnimation(.easeInOut.delay(0.2)) {
                appear[1] = true
            }
        }
    }
    
    func createAccount() {
        if !isValidEmail(email) {
            alertTitle = "Invalid Email"
            alertMessage = "Please enter a valid email address."
            showAlert.toggle()
        } else if !isValidPassword(password) {
            alertTitle = "Invalid Password"
            alertMessage = "Password should be at least 6 characters long."
            showAlert.toggle()
        }
    }

    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }

    func isValidPassword(_ password: String) -> Bool {
        return password.count >= 6
    }
}
