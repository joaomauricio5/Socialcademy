//
//  NewPostForm.swift
//  Socialcademy
//
//  Created by Joao Mauricio on 23/05/2022.
//

import SwiftUI

struct NewPostForm: View {
    @State private var newPost = Post(title: "", content: "", authorName: "")
    @Environment(\.presentationMode) var presentationMode
    
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
    
    private func createPost() {
        print("Post created")
        presentationMode.wrappedValue.dismiss()
    }
}

struct NewPostForm_Previews: PreviewProvider {
    static var previews: some View {
        NewPostForm()
    }
}
