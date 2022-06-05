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
    
    @Published var posts = [Post]()
    @Published var loadingStatus : LoadingStatus = .loading
    let user: User
    
    init(user: User) {
        self.user = user
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
                posts = try await PostsRepository.fetchAllPosts()
                loadingStatus = .loaded
            } catch {
                print("Cannot fetch posts: \(error)")
                loadingStatus = .error
            }
        }
    }
    
    func fetchFavoritePosts() {
        loadingStatus = .loading
        Task {
            do {
                posts = try await PostsRepository.fetchFavoritePosts()
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
                let index = posts.firstIndex(of: post)!
                posts[index].isFavorite.toggle()
            } catch {
                print("Cannot toggle favorite: \(error)")
            }
        }
    }
}
