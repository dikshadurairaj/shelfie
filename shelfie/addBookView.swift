//
//  addBookView.swift
//  shelfie
//
//  Created by Grace Shen on 2025-07-15.
//

import SwiftUI

struct addBookView: View {
    @State public var rating = 0.0
    @State private var selectedStatus: Int? = nil
    
    var body: some View {
        VStack {
                HStack {
                    Spacer()
                    Button("Back") {
                        
                    }
                    .padding(.trailing, 25.0)
                }
            
        
            Text("Add a New Book")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 20.0)
            
            Spacer()
            
            
            Text("Book Title:")
            TextField("Type book name...", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                .padding()
                .background(Color(.systemGroupedBackground))
                .cornerRadius(15)
                .padding()
            
            
              // nothing picked yet

            Picker("Status", selection: $selectedStatus) {     // ← label always reads “Status”
                Text("Want to read").tag(1 as Int?)
                Text("In progress").tag(2 as Int?)
                Text("Read").tag(3 as Int?)
            }
            
            /*Picker(selection: .constant(1), label: Text("Status")) {
                Text("Want to read").tag(1)
                Text("In progress").tag(2)
                Text("Read").tag(3)
            }*/
            
            HStack {
                ForEach(0..<5) { i in //ill fix this later but it doesnt display 0 stars correctly
                    if rating >= Double(i) {
                        Text("star")
                    } else if rating.truncatingRemainder(dividingBy: 1) != 0 && rating >= Double(i) - 0.5 {
                        Text("half star")
                    } else {
                        Text("no star")
                    }
                }
            }
            
            HStack {
                Button("-") {
                    rating = max(0, rating - 0.5)
                }
                
                Text("Rating")
                
                Button("+") {
                    rating = min(5, rating + 0.5)
                }
            }
            
            

            
        }
        
        VStack {
            Spacer()
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
