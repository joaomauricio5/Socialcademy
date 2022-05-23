//
//  PostsRepository.swift
//  Socialcademy
//
//  Created by Joao Mauricio on 23/05/2022.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

struct PostsRepository {
    static let store = Firestore.firestore()
    static let postsReference = store.collection("posts")
    
    static func upload(_ post: Post) throws {
        let document = postsReference.document(post.id.uuidString)
        try document.setData(from: post)
    }
}
