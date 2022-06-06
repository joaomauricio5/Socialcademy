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
        Task {
            isWorking = true
            do {
                try await authService.signIn(email: email, password: password)
            } catch {
                print("[AUTH VIEW MODEL] : \(error)")
                anyError = error
                isThereAnError = true
            }
            isWorking = false
        }
    }
    
    func createAccount(name: String, email: String, password: String) {
        Task {
            isWorking = true
            do {
                try await authService.createAccount(email: email, password: password)
                self.updateCurrentAccountName(name: name)
            } catch {
                print("[AUTH VIEW MODEL] : \(error)")
                anyError = error
                isThereAnError = true
            }
            isWorking = false
        }
    }
    
    func updateCurrentAccountName(name: String) {
        Task {
            isWorking = true
            do {
                try await authService.updateCurrentAccountName(name: name)
            } catch {
                print("[AUTH VIEW MODEL] : \(error)")
                anyError = error
                isThereAnError = true
            }
            isWorking = false
        }
    }
}
