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
                PostsList(viewModel: PostViewModel(user: user, filter: .none))
            }.tabItem {
                Label("Posts", systemImage: "list.bullet")
            }
            
            NavigationView {
                PostsList(viewModel: PostViewModel(user: user, filter: .favorites))
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
