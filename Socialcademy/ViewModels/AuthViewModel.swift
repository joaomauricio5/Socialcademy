//
//  AuthViewModel.swift
//  Socialcademy
//
//  Created by Joao Mauricio on 02/06/2022.
//

import Foundation
import FirebaseAuth

//@MainActor
class AuthViewModel: ObservableObject {
    @Published var isAuthenticated = false
    private let authService = AuthService()
    
    init() {
        authService.$isAuthenticated.assign(to: &$isAuthenticated)
    }
    
    func signIn(email: String, password: String) {
        authService.signIn(email: email, password: password)
    }
}
