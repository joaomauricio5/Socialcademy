//
//  PostsList.swift
//  Socialcademy
//
//  Created by Joao Mauricio on 22/05/2022.
//

import SwiftUI

struct PostsList: View {
    
    @State private var viewModel = PostViewModel()
    
    @State private var searchText: String = ""
    @State private var showNewPostForm = false
    
    var body: some View {
        NavigationView{
            List(viewModel.posts) {post in
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
                NewPostForm(createAction: { post in
                    try viewModel.createPost(post)
                })
            }
        }
    }
}

struct PostsList_Previews: PreviewProvider {
    static var previews: some View {
        PostsList()
    }
}
