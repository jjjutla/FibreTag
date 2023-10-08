//
//  VerificationView.swift
//  SeedSwipe
//
//  Created by Artemiy Malyshau on 21/09/2023.
//

import SwiftUI

struct VerificationView: View {
    
    @State var email = ""
    @State var password = ""
    
    @State var selectedEmail = false
    @State var selectedPass = false
    
    @State var animEmail = false
    @State var animPass = false
    @State var showAlert = false
    @State var alertTitle = ""
    @State var alertMessage = ""
    
    @State var appear = [false,false,false,false]
    
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
                Text("Verify")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                Text("Gain access start-ups and investors, ready to match and conquer!")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.6))
                numberField
                signinBtn
                
                Button {
                    withAnimation(.spring()) {
                        authViewModel.showSignInCard.toggle()
                    }
                    print(authViewModel.showSignInCard)
                } label: {
                    HStack {
                        Text("Don’t have an account?")
                            .font(.footnote)
                            .foregroundColor(.white.opacity(0.6))
                        Text("Sign up")
                            .font(.footnote.weight(.bold))
                            .foregroundLinearGradient()
                    }
                }
                .opacity(appear[2] ? 1 : 0)
                Button {
                    // Reset Password functionality
                } label: {
                    HStack {
                        Text("Forgot password?")
                            .font(.footnote)
                            .foregroundColor(.white.opacity(0.6))
                        Text("Reset Password")
                            .font(.footnote.weight(.bold))
                            .foregroundLinearGradient()
                    }
                }
                .opacity(appear[2] ? 1 : 0)
                .scaleEffect(x: appear[3] ? 1.0 : 1.2)
                .opacity(appear[3] ? 1 : 0)
                .onAppear {
                    withAnimation(.easeInOut.delay(0.6)) {
                        appear[3] = true
                    }
                }
            }
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .stroke(.white.opacity(0.5))
                    .background(.ultraThinMaterial)
                    .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
            )
            .padding(.horizontal, 20)
        }

    
    var numberField : some View {
        HStack(spacing: 12){
            AngularIcon(icon: "phone.fill", selected: $selectedEmail)
                .scaleEffect(animEmail ? 1.2 : 1.0)
            TextField("Verification Code", text: $email)
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
        .onTapGesture{fieldOntapAnimation(isEmail: true)}
        .scaleEffect(x: appear[0] ? 1.0 : 1.2)
        .opacity(appear[0] ? 1 : 0)
        .onAppear{
            withAnimation(.easeInOut) {
                appear[0] = true
            }
        }
    }
    
    var signinBtn : some View {
        AngularButton(title: "Verify") {
//            signin()
        }
        .scaleEffect(x: appear[2] ? 1.0 : 1.2)
        .opacity(appear[2] ? 1 : 0)
        .onAppear{
            withAnimation(.easeInOut.delay(0.4)) {
                appear[2] = true
            }
        }
    }
    
    
    func signin() {
        if !password.isEmpty  {
            authViewModel.exitAuthPage.toggle()
        } else {
            showAlert = true
            alertTitle = "Verification Error"
//            alertMessage = message
        }
    }
    
    func resetPassword() {
        
    }
    
    func fieldOntapAnimation(isEmail : Bool){
        if !isEmail{
            withAnimation(.easeInOut) {
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
        else{
            withAnimation(.easeInOut) {
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

    }

    
}

//#Preview {
//    VerificationView()
//}
