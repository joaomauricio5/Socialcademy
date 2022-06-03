//
//  AuthView.swift
//  Socialcademy
//
//  Created by Joao Mauricio on 02/06/2022.
//

import SwiftUI

import FirebaseAuth

struct AuthView: View {
    
    @State private var email = ""
    @State private var password = ""

    @StateObject var authViewModel = AuthViewModel()
    
    var body: some View {
        if authViewModel.isAuthenticated {
            MainTabView()
        } else {
            Form {
                TextField("Email", text: $email)
                SecureField("Password", text: $password)
                Button("Sign In") {
                    authViewModel.signIn(email: email, password: password)
                }
            }
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
