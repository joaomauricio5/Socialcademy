//
//  Post.swift
//  Socialcademy
//
//  Created by Joao Mauricio on 22/05/2022.
//

import Foundation

struct Post: Identifiable, Codable {
    var id = UUID()
    var title: String
    var content: String
    var authorName: String
    var timestamp = Date()
    
    func contains(_ string: String) -> Bool {
        let components = [title, content, authorName].map{$0.lowercased()}
        let equivalent = components.filter{$0.contains(string.lowercased().trimmingCharacters(in: .whitespacesAndNewlines))}
        return !equivalent.isEmpty
    }

    
    static let testPost = Post(title: "Lorem ipsum",
                           content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                           authorName: "Jamie Harris", timestamp: Date())
}


