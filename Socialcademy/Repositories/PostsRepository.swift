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
        try document.delete() { error in
            if let error = error {
                print("Error deleting document: \(error) ")
                fatalError()
            } else {
                print("SUCCESS")
            }
        }
    }
    
    static func fetchAllPosts() async throws -> [Post] {
        try await fetchPosts(from: postsReference)
    }
    
    static func fetchFavoritePosts() async throws -> [Post] {
        try await fetchPosts(from: postsReference.whereField("isFavorite", isEqualTo: true))
    }
    
    static private func fetchPosts(from query: Query) async throws -> [Post] {
        let snapshot = try await query.order(by: "timestamp", descending: true).getDocuments()
        return snapshot.documents.compactMap { document in
             try! document.data(as: Post.self)
        }
    }
    
    static func toggleFavorite(for post: Post) {
        let document = PostsRepository.postsReference.document(post.id.uuidString)
        try document.setData(["isFavorite": post.isFavorite ? false : true], merge: true)
    }
}
