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
        
        var isError: Bool {
            get {
                self == .error
            }
            set {
                //guard !newValue else {return}
                self = .idle
            }
        }
    }
    
    let user: User
    @State private var state = FormState.idle
    @State var newPost: Post
    
    
    @Environment(\.dismiss) var dismiss
    
    typealias CreateAction = (Post) throws -> Void
    let createAction: CreateAction
    
    private func createPost() {
        state = .working
        do {
            try createAction(newPost)
            print("Post created")
            dismiss()
        } catch  {
            state = .error
            print("ERROR: Cannot create post: \(error)")
        }
    }

    var body: some View {
        NavigationView{
            Form {
                Section{
                    TextField("Title", text: $newPost.title)
                    Text(user.name)
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
            .disabled(state == .working)
            .alert("Error while uploading post", isPresented: $state.isError) {
                Button("OK") {
                    
                }
            }
        }
    }
}

struct NewPostForm_Previews: PreviewProvider {
    static var previews: some View {
        NewPostForm(user: User.testUser, newPost: Post(title: "Title", content: "Content", author: User.testUser), createAction: {_ in })
    }
}
