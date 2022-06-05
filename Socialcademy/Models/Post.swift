//
//  Post.swift
//  Socialcademy
//
//  Created by Joao Mauricio on 22/05/2022.
//

import Foundation

struct Post: Identifiable, Codable, Equatable {
    var id = UUID()
    var title: String
    var content: String
    var author: User
    var timestamp = Date()
    var isFavorite = false
    
    func contains(_ string: String) -> Bool {
        let components = [title, content, author.name].map{$0.lowercased()}
        let equivalent = components.filter{$0.contains(string.lowercased().trimmingCharacters(in: .whitespacesAndNewlines))}
        return !equivalent.isEmpty
    }

    
    static let testPost = Post(title: "Lorem ipsum",
                           content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                               author: User.testUser, timestamp: Date(), isFavorite: true)
}


