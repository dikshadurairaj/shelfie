//
//  writeReviewView.swift
//  shelfie
//
//  Created by Harleen Monder on 2025-07-15.
//

import SwiftUI

struct WriteReviewView: View {
    @State private var bookName = "Sample Book"
    @State private var reviewText = ""      // <-- Store user input here
    @State private var showingAlert = false // <-- Show confirmation
    
    var body: some View {
        VStack {
            Text("Review for \(bookName)")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            TextField("Type here...", text: $reviewText)  // <-- bind to state
                .frame(width: 300, height: 100)
                .padding()
                .background(Color(.systemGroupedBackground))
                .cornerRadius(15)
                .padding()
            
            Button("Save") {
                // For now, just print review to console
                print("Saved review: \(reviewText)")
                
                // Show a confirmation alert
                showingAlert = true
                
                // Here, you could also add code to save to a model, file, database, etc.
            }
            .font(.title2)
            .buttonStyle(.bordered)
            .tint(.purple)
            .padding(.top)
            .alert("Review Saved", isPresented: $showingAlert) {
                Button("OK", role: .cancel) { }
            }
        }
        .padding()
    }
}

struct WriteReviewView_Previews: PreviewProvider {
    static var previews: some View {
        WriteReviewView()
    }
}

