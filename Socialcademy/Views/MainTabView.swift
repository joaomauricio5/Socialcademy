//
//  MainTabView.swift
//  Socialcademy
//
//  Created by Joao Mauricio on 01/06/2022.
//

import SwiftUI

struct MainTabView: View {

    let user: User
    
    var body: some View {
        TabView {
            
            NavigationView {
                PostsList(filter: .none, viewModel: PostViewModel(user: user))
            }.tabItem {
                Label("Posts", systemImage: "list.bullet")
            }
            
            NavigationView {
                PostsList(filter: .favorites, viewModel: PostViewModel(user: user))
            }.tabItem {
                Label("Favorites", systemImage: "heart.fill")
            }
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView(user: .testUser)
    }
}
