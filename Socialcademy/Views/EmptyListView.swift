//
//  EmptyListView.swift
//  Socialcademy
//
//  Created by Joao Mauricio on 30/05/2022.
//

import SwiftUI

struct EmptyListView: View {
    var title: String
    var message: String
    var action: (() -> Void)?
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text(title)
                .font(.title2)
            .fontWeight(.semibold)
            
            Text(message)
                .foregroundColor(.secondary)
            
            if action != nil {
                Button(action: action!) {
                    Text("Try again")
                        .bold()
                        .foregroundColor(.secondary)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).stroke(Color.secondary))
                }
                .padding()
            }
        }
    }
}

struct EmptyListView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyListView(title: "No Posts", message: "There aren't any posts yet.", action: {})
    }
}
