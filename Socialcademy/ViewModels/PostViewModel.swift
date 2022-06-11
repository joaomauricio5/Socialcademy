//
//  PostViewModel.swift
//  Socialcademy
//
//  Created by Joao Mauricio on 23/05/2022.
//

import Foundation

@MainActor
class PostViewModel: ObservableObject {
    
    enum LoadingStatus {
        case loading, loaded, error
    }

    enum Filter: Equatable {
        case none
        case favorites
        case author(User)
    }
    let filter: Filter
    
    var isFilteringByAuthor: Bool {
        switch filter {
        case .author(_):
            return true
        default:
            return false
        }
    }
    
    var navigationTitle: String {
        switch filter {
        case .none:
            return "Posts"
        case .favorites:
            return "Favorites"
        case let .author(author):
            return "\(author.name)'s Posts"
        }
    }
    
    @Published var posts = [Post]()
    @Published var loadingStatus : LoadingStatus = .loading
    let user: User
    
    init(user: User, filter: Filter) {
        self.user = user
        self.filter = filter
    }
    
    func createPost(_ post: Post) {
        do {
            try PostsRepository.upload(post)
            posts.insert(post, at: 0)
        } catch {
            print("Error creating the post: \(error)")
        }
    }
    
    func deletePost(_ post: Post) {
        Task {
            do {
                posts.removeAll() {$0.id == post.id}
                try await PostsRepository.delete(post)
            } catch {
                print("Error creating the post: \(error)")
            }
        }
    }
    
    func fetchPosts() {
        loadingStatus = .loading
        Task {
            do {
                switch filter {
                case .none:
                    posts = try await PostsRepository.fetchAllPosts()
                case .favorites:
                    posts = try await PostsRepository.fetchFavoritePosts()
                case .author(let author):
                    posts = try await PostsRepository.fetchPosts(by: author)
                }
                loadingStatus = .loaded
            } catch {
                print("Cannot fetch posts: \(error)")
                loadingStatus = .error
            }
        }
    }
    
    func toggleFavorite(for post: Post) {
        Task {
            do {
                try await PostsRepository.toggleFavorite(for: post)
                if let index = posts.firstIndex(of: post) {
                    posts[index].isFavorite.toggle()
                }
            } catch {
                print("Cannot toggle favorite: \(error)")
            }
        }
    }
    
    func canCurrentUserDeletePost(post: Post) -> Bool {
        post.author.id == user.id
    }
}
