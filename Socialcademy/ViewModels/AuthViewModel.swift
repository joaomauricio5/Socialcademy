//
//  AuthViewModel.swift
//  Socialcademy
//
//  Created by Joao Mauricio on 02/06/2022.
//

import Foundation

@MainActor
class AuthViewModel: ObservableObject {
    
    @Published var user: User?
    @Published var isWorking = false
    
    var anyError: Error?
    @Published var isThereAnError: Bool = false
    
    
    private let authService = AuthService()
    
    init() {
        authService.$user.assign(to: &$user)
    }
    
    func signIn(email: String, password: String) {
        withErrorHandling {
            try await self.authService.signIn(email: email, password: password)
        }
    }
    
    func createAccount(name: String, email: String, password: String) {
        withErrorHandling {
            try await self.authService.createAccount(email: email, password: password)
            self.updateCurrentAccountName(name: name)
        }
    }
    
    func updateCurrentAccountName(name: String) {
        withErrorHandling {
            try await self.authService.updateCurrentAccountName(name: name)
        }
    }
    
    private func withErrorHandling(perform action: @escaping () async throws -> Void) {
        Task {
            isWorking = true
            do {
                try await action()
            } catch {
                print("[AUTH VIEW MODEL] : \(error)")
                anyError = error
                isThereAnError = true
            }
            isWorking = false
        }
    }
}
