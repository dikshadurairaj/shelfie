//
//  addBookView.swift
//  shelfie
//
//  Created by Grace Shen on 2025-07-15.
//

import SwiftUI

struct addBookView: View {
    @State private var rating = 0.0
    
    var body: some View {
        VStack {
            Text("Book Title:")
                .font(.title)
                .fontWeight(.bold)
            
            TextField("Type book name...", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                .padding()
                .background(Color(.systemGroupedBackground))
                .cornerRadius(15)
                .padding()
            
            Text("\(rating)")
            
            HStack {
                Button("-") {
                    rating = rating - 0.5
                }
                
                Text("Rating")
                
                Button("+") {
                    rating = rating + 0.5
                }
            }
            
            Button("Add book") {
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
            }
            .font(.title)
            .fontWeight(.bold)
            
        }
        .padding()
    }
}

#Preview {
    addBookView()
}
