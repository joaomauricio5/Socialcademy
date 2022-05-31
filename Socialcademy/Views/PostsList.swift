//
//  PostsList.swift
//  Socialcademy
//
//  Created by Joao Mauricio on 22/05/2022.
//

import SwiftUI

struct PostsList: View {
    
    @StateObject private var viewModel = PostViewModel()
    
    @State private var searchText: String = ""
    @State private var showNewPostForm = false
    
    var body: some View {
        NavigationView{
            Group {
                switch viewModel.loadingStatus {
                case .loading:
                    ProgressView()
                case .error:
                    EmptyListView(title: "Cannot Load Posts", message: "Retry or check your connection.", action: {viewModel.fetchPosts()})
                case .loaded:
                    if viewModel.posts.isEmpty {
                        EmptyListView(title: "No Posts", message: "There aren't any posts yet.")
                    } else {
                        List(viewModel.posts) {post in
                            if searchText.isEmpty || post.contains(searchText){
                                PostRow(post: post)
                                Button(action: {viewModel.deletePost(post)}) { Text("DELETE")}
                            }
                        }
                        .searchable(text: $searchText)
                    }
                }
            }
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
        }.onAppear {
            viewModel.fetchPosts()
        }
    }
}

struct PostsList_Previews: PreviewProvider {
    static var previews: some View {
        PostsList()
    }
}
