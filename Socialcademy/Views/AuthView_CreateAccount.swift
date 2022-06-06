//
//  AuthView_CreateAccount.swift
//  Socialcademy
//
//  Created by Joao Mauricio on 03/06/2022.
//

import SwiftUI

struct AuthView_CreateAccount: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var name = ""

    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        Form {
            TextField("Name", text: $name)
                .textContentType(UITextContentType.name)
                //.textInputAutocapitalization(.never)
            
            TextField("Email", text: $email)
                .textContentType(UITextContentType.emailAddress)
                .textInputAutocapitalization(.never)
            
            SecureField("Password", text: $password)
                .textContentType(UITextContentType.newPassword)
            
            Button("Create Account") {
                authViewModel.createAccount(name: name, email: email, password: password)
            }
        }
        .alert("\(authViewModel.anyError?.localizedDescription ?? "Error occured")", isPresented: $authViewModel.isThereAnError) {
            Button("OK", role: .cancel) {}
        }
    }
}

struct AuthView_CreateAccount_Previews: PreviewProvider {
    static var previews: some View {
        AuthView_CreateAccount()
    }
}
