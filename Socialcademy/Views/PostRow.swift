//
//  PostRow.swift
//  Socialcademy
//
//  Created by Joao Mauricio on 22/05/2022.
//

import SwiftUI

struct PostRow: View {
    
    @EnvironmentObject var viewModel: PostViewModel
    let post: Post
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            HStack {
                Text(post.authorName)
                    .font(.subheadline)
                    .fontWeight(.light)

                Spacer()

                Text(post.timestamp.formatted(date: .abbreviated, time: .shortened))
                    .font(.subheadline)
                    .fontWeight(.light)
            }
            .foregroundColor(.gray)

            Text(post.title)
                .font(.title3)
                .fontWeight(.semibold)
            
            Text(post.content)
            
            HStack{
                Spacer()
                Button(role: .destructive,
                       action: {viewModel.deletePost(post)}) {
                    Label("Trash bin", systemImage: "trash")
                        .labelStyle(.iconOnly)
                }
                .padding(.trailing)
                .buttonStyle(.borderless)
            }
        }
        .padding(.vertical)
    }
}

struct PostRow_Previews: PreviewProvider {
    static var previews: some View {
        List{
            PostRow(post: Post.testPost)
        }
    }
}
