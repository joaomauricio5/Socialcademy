//
//  AuthViewModel.swift
//  Socialcademy
//
//  Created by Joao Mauricio on 02/06/2022.
//

import Foundation

//@MainActor
class AuthViewModel: ObservableObject {
    @Published var isAuthenticated = false
    @Published var isWorking = false
    
    private let authService = AuthService()
    
    init() {
        authService.$isAuthenticated.assign(to: &$isAuthenticated)
    }
    
    func signIn(email: String, password: String) {
        Task {
            isWorking = true
            do {
                try await authService.signIn(email: email, password: password)
            } catch {
                print("[AUTH VIEW MODEL] : \(error)")
            }
            isWorking = false
        }
    }
    
    func createAccount(email: String, password: String) {
        Task {
            isWorking = true
            do {
                try await authService.createAccount(email: email, password: password)
            } catch {
                print("[AUTH VIEW MODEL] : \(error)")
            }
            isWorking = false
        }
    }
}
