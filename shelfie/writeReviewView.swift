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
        Text("Review for \(bookName)")
            .font(.largeTitle)
            .fontWeight(.bold)
            Spacer()
        
        TextField("Type here", text: $bookName)
    }
}

#Preview {
    writeReviewView()
}
