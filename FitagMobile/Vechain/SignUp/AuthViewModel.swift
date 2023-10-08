//
//  AuthViewModel.swift
//  SeedSwipe
//
//  Created by Artemiy Malyshau on 18/09/2023.
//

import Foundation

class AuthViewModel: ObservableObject {
    
    @Published var showSignInCard = false
    @Published var exitAuthPage = false
    @Published var verificationPage = false
    
}
