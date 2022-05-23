//
//  PostsList.swift
//  Socialcademy
//
//  Created by Joao Mauricio on 22/05/2022.
//

import SwiftUI

struct PostsList: View {
    private var posts = [Post.testPost]
    @State private var searchText: String = ""
    @State private var showNewPostForm = false
    
    var body: some View {
        NavigationView{
            List(posts) {post in
                if searchText.isEmpty || post.contains(searchText){
                    PostRow(post: post)
                }
            }
            .searchable(text: $searchText)
            .navigationTitle("Posts")
            .toolbar{
                Button(action: {showNewPostForm = true}) {
                    Label("New Post", systemImage: "square.and.pencil")
                }
            }
            .sheet(isPresented: $showNewPostForm) {
                NewPostForm()
            }
        }
    }
}

struct PostsList_Previews: PreviewProvider {
    static var previews: some View {
        PostsList()
    }
}
