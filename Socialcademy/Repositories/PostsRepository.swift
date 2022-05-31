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
    
    static func delete(_ post: Post) {
        let document = postsReference.document(post.id.uuidString)
        document.delete()
    }
    
    static func fetchPosts() async throws -> [Post] {
        let querySnapshot = try await postsReference.order(by: "timestamp", descending: true).getDocuments()
        return querySnapshot.documents.compactMap {document in
            try! document.data(as: Post.self)
        }
    }
}
