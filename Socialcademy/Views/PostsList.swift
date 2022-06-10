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
        case author(User)
    }
    
    let filter: Filter
    
    private var navigationTitle: String {
        switch filter {
        case .none:
            return "Posts"
        case .favorites:
            return "Favorites"
        case let .author(author):
            return "\(author.name)'s Posts"
        }
    }
    
    @StateObject var viewModel : PostViewModel
    
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
                        case let .author(author):
                            viewModel.fetchPosts(by: author)
                        }
                    })
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
            .navigationTitle(navigationTitle)
            .toolbar{
                Button(action: {showNewPostForm = true}) {
                    Label("New Post", systemImage: "square.and.pencil")
                }
            }
            .sheet(isPresented: $showNewPostForm) {
                NewPostForm(user: viewModel.user, newPost: Post(title: "", content: "", author: viewModel.user), createAction: { post in
                    viewModel.createPost(post)
                })
            }
        }
        .onAppear {
            switch filter {
            case .none:
                viewModel.fetchPosts()
            case .favorites:
                viewModel.fetchFavoritePosts()
            case let .author(author):
                viewModel.fetchPosts(by: author)
            }
        }
    }
}

struct PostsList_Previews: PreviewProvider {
    static var previews: some View {
        PostsList(filter: .none, viewModel: PostViewModel(user: User.testUser))
    }
}
