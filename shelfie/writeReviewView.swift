//
//  writeReviewView.swift
//  shelfie
//
//  Created by Harleen Monder on 2025-07-15.
//

import SwiftUI

struct writeReviewView: View {
    @State private var bookName = ""
    
    var body: some View {
        VStack {
            Text("Review for \(bookName)")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            TextField("Type here...", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                .frame(width: 300, height: 25)
                .padding()
                .background(Color(.systemGroupedBackground))
                .cornerRadius(15)
                .padding()
            
            Button("Save") {
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
            }
            .font(.title2)
            .buttonStyle(.bordered)
            .tint(.purple)
            .padding(.top)
                
        }
        
        .padding()
    }
}

#Preview {
    writeReviewView()
}
