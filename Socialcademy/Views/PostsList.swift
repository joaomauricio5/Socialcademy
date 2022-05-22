//
//  PostsList.swift
//  Socialcademy
//
//  Created by Joao Mauricio on 22/05/2022.
//

import SwiftUI

struct PostsList: View {
    @State private var posts = [Post.testPost]
    var body: some View {
        NavigationView{
            List(posts) {post in
                Text(post.content)
            }.navigationTitle("Posts")
        }
    }
}

struct PostsList_Previews: PreviewProvider {
    static var previews: some View {
        PostsList()
    }
}
