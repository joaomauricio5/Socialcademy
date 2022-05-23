//
//  NewPostForm.swift
//  Socialcademy
//
//  Created by Joao Mauricio on 23/05/2022.
//

import SwiftUI

struct NewPostForm: View {
    @State private var newPost = Post(title: "", content: "", authorName: "")
    @Environment(\.dismiss) var dismiss
    
    typealias CreateAction = (Post) -> Void
    let createAction: CreateAction
    
    private func createPost() {
        createAction(newPost)
        print("Post created")
        dismiss()
    }

    
    var body: some View {
        NavigationView{
            Form {
                Section{
                    TextField("Title", text: $newPost.title)
                    TextField("Author", text: $newPost.authorName)
                }
                Section("Content") {
                    TextEditor(text: $newPost.content)
                }
                
                Button(action: createPost) {
                    Text("Create Post")
                        .font(.headline)
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                }
                .listRowBackground(Color.blue)
            }
            .navigationTitle("New Post")
        }
    }
}

struct NewPostForm_Previews: PreviewProvider {
    static var previews: some View {
        NewPostForm(createAction: {_ in })
    }
}
