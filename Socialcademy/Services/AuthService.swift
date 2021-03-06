//
//  AuthService.swift
//  Socialcademy
//
//  Created by Joao Mauricio on 02/06/2022.
//

import Foundation
import FirebaseAuth

@MainActor
class AuthService: ObservableObject {
    @Published var isAuthenticated = false
    @Published var user: User?
    
    private let auth = Auth.auth()
    private var listener: AuthStateDidChangeListenerHandle?
    
    init() {
        listener = auth.addStateDidChangeListener { /*[weak self]*/ _, user in
            /*self/*?*/.isAuthenticated = (user != nil)*/
            self.user = user.map(User.init(from:))
        }
    }
    
    func signIn(email: String, password: String) async throws {
        try await auth.signIn(withEmail: email, password: password)
    }
    
    func createAccount(name: String, email: String, password: String) async throws {
        try await auth.createUser(withEmail: email, password: password)
        try await updateCurrentAccountName(name: name)
    }
    
    func updateCurrentAccountName(name: String) async throws {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = name
        try await changeRequest?.commitChanges()
        user?.name = name
    }
}
