//
//  MainTabView.swift
//  Socialcademy
//
//  Created by Joao Mauricio on 01/06/2022.
//

import SwiftUI

struct MainTabView: View {
    
    @EnvironmentObject private var viewModel: PostViewModel
    
    var body: some View {
        TabView {
            
            NavigationView {
                PostsList(filter: .none, viewModel: viewModel)
            }.tabItem {
                Label("Posts", systemImage: "list.bullet")
            }
            
            NavigationView {
                PostsList(filter: .favorites, viewModel: viewModel)
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
        MainTabView()
    }
}
