//
//  PostViewModel.swift
//  Socialcademy
//
//  Created by Joao Mauricio on 23/05/2022.
//

import Foundation

struct PostViewModel {
    var posts = [Post.testPost]
    
    mutating func createPost(_ post: Post) throws {
        posts.insert(post, at: 0)
        try PostsRepository.upload(post)
    }
}
