//
//  PostViewModel.swift
//  Socialcademy
//
//  Created by Joao Mauricio on 23/05/2022.
//

import Foundation

struct PostViewModel {
    var posts = [Post.testPost]
    
    mutating func createPost(_ post: Post) {
        posts.insert(post, at: 0)
    }
}
