//
//  ProfileView.swift
//  Socialcademy
//
//  Created by Joao Mauricio on 03/06/2022.
//

import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    var body: some View {
        
        Button("Sign out PLACEHOLDER") {
            try! Auth.auth().signOut()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
