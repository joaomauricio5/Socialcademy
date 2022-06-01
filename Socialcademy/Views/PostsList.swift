//
//  PostsList.swift
//  Socialcademy
//
//  Created by Joao Mauricio on 22/05/2022.
//

import SwiftUI


struct PostsList: View {
    
    enum Filter {
        case none
        case favorites
    }
    
    private let filter: Filter
    
    init(filter: Filter = .none) {
        self.filter = filter
    }
    
    @EnvironmentObject private var viewModel : PostViewModel
    
    @State private var searchText: String = ""
    @State private var showNewPostForm = false
    
    var body: some View {
        NavigationView{
            Group {
                switch viewModel.loadingStatus {
                case .loading:
                    ProgressView()
                case .error:
                    EmptyListView(title: "Cannot Load Posts", message: "Retry or check your connection.", action: {
                        switch filter {
                        case .none:
                            viewModel.fetchPosts()
                        case .favorites:
                            viewModel.fetchFavoritePosts()
                        }
                    })
                case .loaded:
                    if viewModel.posts.isEmpty {
                        EmptyListView(title: "No Posts", message: "There aren't any posts yet.")
                    } else {
                        List(viewModel.posts) {post in
                            if searchText.isEmpty || post.contains(searchText){
                                PostRow(post: post)
                                    .environmentObject(viewModel)
                            }
                        }
                        .searchable(text: $searchText)
                        .animation(Animation.default, value: viewModel.posts)
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
            switch filter {
            case .none:
                viewModel.fetchPosts()
            case .favorites:
                viewModel.fetchFavoritePosts()
            }
        }
    }
}

struct PostsList_Previews: PreviewProvider {
    static var previews: some View {
        PostsList()
    }
}
