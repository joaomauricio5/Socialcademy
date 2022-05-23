//
//  NewPostForm.swift
//  Socialcademy
//
//  Created by Joao Mauricio on 23/05/2022.
//

import SwiftUI

struct NewPostForm: View {
    
    enum FormState {
        case idle, working, error
    }
    
    @State private var state = FormState.error
    
    @State private var newPost = Post(title: "", content: "", authorName: "")
    
    @Environment(\.dismiss) var dismiss
    
    typealias CreateAction = (Post) -> Void
    let createAction: CreateAction
    
    private func createPost() {
        state = .working
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
                    if state == .working {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .black))
                    } else {
                        Text("Create Post")
                            .font(.headline)
                            .bold()
                            .foregroundColor(.white)
                    }
                }
                .padding()
                .listRowBackground(Color.blue)
                .frame(maxWidth: .infinity)
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
