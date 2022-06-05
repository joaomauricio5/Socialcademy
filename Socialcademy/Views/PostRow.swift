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
    
    @State private var isConfirmationShowing = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            HStack {
                Text(post.author.name)
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
                
                Button(action: { viewModel.toggleFavorite(for: post) } ) {
                    Label("Toggle favorite", systemImage: post.isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(post.isFavorite ? .red : .gray)
                }
                
                Spacer()
                
                Button(role: .destructive,
                       action: { isConfirmationShowing = true }) {
                    Label("Trash bin", systemImage: "trash")
                }
                       .confirmationDialog("Are you sure you want to delete this post?",
                                           isPresented: $isConfirmationShowing,
                                           titleVisibility: Visibility.visible) {
                           Button("Delete", role: .destructive) { viewModel.deletePost(post) }
                       }
            }
        }
        .padding(.vertical)
        .buttonStyle(.borderless)
        .labelStyle(.iconOnly)
    }
}

struct PostRow_Previews: PreviewProvider {
    static var previews: some View {
        List{
            PostRow(post: Post.testPost)
        }
    }
}
