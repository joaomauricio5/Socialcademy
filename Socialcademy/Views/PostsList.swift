//
//  PostsList.swift
//  Socialcademy
//
//  Created by Joao Mauricio on 22/05/2022.
//

import SwiftUI


struct PostsList: View {
    
    @StateObject var viewModel : PostViewModel
    
    @State private var searchText: String = ""
    @State private var showNewPostForm = false
    
    var body: some View {
        Group {
            switch viewModel.loadingStatus {
            case .loading:
                ProgressView()
            case .error:
                EmptyListView(title: "Cannot Load Posts", message: "Retry or check your connection.", action: { viewModel.fetchPosts() })
            case .loaded:
                if viewModel.posts.isEmpty {
                    EmptyListView(title: "No Posts", message: "There aren't any posts yet.")
                } else {
                    ScrollView {
                        ForEach(viewModel.posts) {post in
                            if searchText.isEmpty || post.contains(searchText){
                                PostRow(post: post, currentUserCanDeletePost: viewModel.canCurrentUserDeletePost(post: post))
                                    .environmentObject(viewModel)
                            }
                        }
                        .searchable(text: $searchText)
                        .animation(Animation.default, value: viewModel.posts)
                    }
                }
            }
        }
        .navigationTitle(viewModel.navigationTitle)
        .toolbar{
            if viewModel.filter == .none {
                Button(action: {showNewPostForm = true}) {
                    Label("New Post", systemImage: "square.and.pencil")
                }
            }
        }
        .sheet(isPresented: $showNewPostForm) {
            NewPostForm(user: viewModel.user, newPost: Post(title: "", content: "", author: viewModel.user), createAction: { post in
                viewModel.createPost(post)
            })
        }
        .onAppear {
            viewModel.fetchPosts()
        }
    }
}

struct PostsList_Previews: PreviewProvider {
    static var previews: some View {
        PostsList(viewModel: PostViewModel(user: User.testUser, filter: .none))
    }
}
