//
//  editBookView.swift
//  shelfie
//
//  Created by Grace Shen on 2025-07-16.
//

import SwiftUI

struct editBookView: View {
    @Environment(\.dismiss) var dismiss

    var book: bookItem
    var onSave: (bookItem) -> Void

    @State private var title: String
    @State private var rating: Double
    @State private var status: String
    @State private var review: String

    let statuses = ["Want to read", "In progress", "Read"]

    init(book: bookItem, onSave: @escaping (bookItem) -> Void) {
        self.book = book
        self.onSave = onSave
        _title = State(initialValue: book.title)
        _rating = State(initialValue: Double(book.rating))
        _status = State(initialValue: book.status)
        _review = State(initialValue: book.review)
    }

    var body: some View {
        VStack(spacing: 20) {
            TextField("Book title", text: $title)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)

            HStack {
                ForEach(1...5, id: \.self) { i in
                    Image(systemName: rating >= Double(i) ? "star.fill" :
                          (rating >= Double(i) - 0.5 ? "star.leadinghalf.filled" : "star"))
                        .foregroundColor(.yellow)
                }
            }

            HStack {
                Button("-") {
                    rating = max(0, rating - 0.5)
                }
                Spacer()
                Text("Rating: \(String(format: "%.1f", rating))")
                Spacer()
                Button("+") {
                    rating = min(5, rating + 0.5)
                }
            }
            .padding(.horizontal, 50)

            Picker("Status", selection: $status) {
                ForEach(statuses, id: \.self) { option in
                    Text(option)
                }
            }
            .pickerStyle(.segmented)
            
            TextField("Type your review here...", text: $review)  // <-- bind to state
                .frame(width: 325, height: 100)
                .padding()
                .background(Color(.systemGroupedBackground))
                .cornerRadius(15)

            Button("Save") {
                let updatedBook = bookItem(
                    title: title,
                    rating: Float(rating),
                    review: review,
                    status: status,
                )
                onSave(updatedBook)
                dismiss()
            }
            .disabled(title.isEmpty)
            .font(.title3)
            .fontWeight(.bold)
            .padding(.top, 20)

            Spacer()
        }
        .padding()
        .navigationTitle("Edit Book")
    }
}
