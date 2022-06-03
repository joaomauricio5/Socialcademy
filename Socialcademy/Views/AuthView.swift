//
//  AuthView.swift
//  Socialcademy
//
//  Created by Joao Mauricio on 02/06/2022.
//

import SwiftUI

struct AuthView: View {
    
    @State private var email = ""
    @State private var password = ""

    @StateObject var authViewModel = AuthViewModel()
    
    var body: some View {
        if authViewModel.isAuthenticated {
            MainTabView()
        } else {
            NavigationView{
                VStack {
                    Text("Socialcademy")
                        .bold()
                        .font(.title)
                        .padding(.vertical, 20.0)
                    Group {
                        TextField("Email", text: $email)
                            .textContentType(UITextContentType.emailAddress)
                            .textInputAutocapitalization(.never)
                        
                        SecureField("Password", text: $password)
                            .textContentType(UITextContentType.password)
                    }
                    .padding()
                    .background(Color.secondary.opacity(0.15))
                    .cornerRadius(10)
                    
                    Button(action: {authViewModel.signIn(email: email, password: password)}) {
                        if authViewModel.isWorking {
                            ProgressView()
                        } else {
                            Text("Sign In")
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(authViewModel.isWorking ? Color.gray : Color.blue)
                    .cornerRadius(10)
                    .padding(.top, 30.0)
                    

                    NavigationLink("Create Account") {
                        AuthView_CreateAccount()
                            .navigationTitle("Create Account")
                            .environmentObject(authViewModel)
                    }
                    .padding()
                }
                .navigationTitle("Sign In")
                .navigationBarHidden(true)
            }
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
