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
    
    func createPost(_ post: Post) throws {
        posts.insert(post, at: 0)
        try PostsRepository.upload(post)
    }
    
    func deletePost(_ post: Post) {
        posts.removeAll() {$0.id == post.id}
        PostsRepository.delete(post)
    }
    
    func fetchPosts() {
        loadingStatus = .loading
        Task {
            do {
                posts = try await PostsRepository.fetchPosts()
                loadingStatus = .loaded
            } catch {
                print("Cannot fetch posts: \(error)")
                loadingStatus = .error
            }
        }
    }
    
    func toggleFavorite(for post: Post) {
        PostsRepository.toggleFavorite(for: post)
        let index = posts.firstIndex(of: post)!
        posts[index].isFavorite.toggle()
    }
}
