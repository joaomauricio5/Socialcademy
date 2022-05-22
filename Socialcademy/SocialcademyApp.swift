//
//  SocialcademyApp.swift
//  Socialcademy
//
//  Created by Joao Mauricio on 22/05/2022.
//

import SwiftUI
import Firebase

@main
struct SocialcademyApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
