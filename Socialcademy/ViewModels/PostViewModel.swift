//
//  PostViewModel.swift
//  Socialcademy
//
//  Created by Joao Mauricio on 23/05/2022.
//

import Foundation

@MainActor
class PostViewModel: ObservableObject {
    @Published var posts = [Post]()
    
    func createPost(_ post: Post) throws {
        posts.insert(post, at: 0)
        try PostsRepository.upload(post)
    }
    
    func fetchPosts() {
        Task {
            do {
                posts = try await PostsRepository.fetchPosts()
            } catch {
                print("Cannot fetch posts: \(error)")
            }
        }
    }
}
