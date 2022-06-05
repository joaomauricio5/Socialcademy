//
//  User.swift
//  Socialcademy
//
//  Created by Joao Mauricio on 04/06/2022.
//

import Foundation
import FirebaseAuth

struct User: Codable, Equatable {
    var id: String
    var name: String
    
    init(from firebaseUser: FirebaseAuth.User) {
        self.id = firebaseUser.uid
        self.name = firebaseUser.displayName ?? ""
    }
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
    
    static let testUser = User(id: "12321", name: "Jamie Harris")
}
