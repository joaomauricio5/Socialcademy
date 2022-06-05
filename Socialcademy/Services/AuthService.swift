//
//  AuthService.swift
//  Socialcademy
//
//  Created by Joao Mauricio on 02/06/2022.
//

import Foundation
import FirebaseAuth

// @MainActor
class AuthService: ObservableObject {
    @Published var isAuthenticated = false
    @Published var user: User?
    
    private let auth = Auth.auth()
    private var listener: AuthStateDidChangeListenerHandle?
    
    init() {
        listener = auth.addStateDidChangeListener { /*[weak self]*/ _, user in
            /*self/*?*/.isAuthenticated = (user != nil)*/
            self.user = user.map(User.init(from: ))
        }
    }
    
    func signIn(email: String, password: String) async throws {
        try await auth.signIn(withEmail: email, password: password)
    }
    
    func createAccount(email: String, password: String) async throws {
        try await auth.createUser(withEmail: email, password: password)
    }
}
