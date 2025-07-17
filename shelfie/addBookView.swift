//
//  AddBookView.swift
//  shelfie
//
//  Created by Grace Shen on 2025-07-16.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.dismiss) var dismiss

    @State private var title = ""
    @State public var rating = 0.0
    @State private var status = "Want to read"
    @State private var review = ""
    @State private var writingReview = false

    var onAdd: (bookItem) -> Void

    let statuses = ["Want to read", "In progress", "Read"]

    @State private var pressedAdd = false
    @State private var pressedDismiss = false
    @State private var pressedMinus = false
    @State private var pressedPlus = false
    @State private var pressedWriteReview = false

    var body: some View {
        ZStack(alignment: .topTrailing) {
            LinearGradient(
                gradient: Gradient(colors: [Color(hex: "F4DAF9"), Color(hex: "FFECE9")]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Color.clear.frame(height: 60)

                    Text("Book Title")
                        .font(.system(.title2, design: .rounded).bold())
                        .tracking(1.2)
                        .foregroundColor(Color(hex: "6B4C8B"))
                        .padding(.horizontal)

                    TextField("Type book name...", text: $title)
                        .padding()
                        .background(Color.white.opacity(0.85))
                        .clipShape(Capsule())
                        .overlay(
                            Capsule()
                                .stroke(Color(hex: "B69FD5"), lineWidth: 1.5)
                        )
                        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                        .padding(.horizontal)

                    Divider()
                        .padding(.horizontal)

                    Text("Rate This Book")
                        .font(.system(.headline, design: .rounded).bold())
                        .tracking(1.2)
                        .foregroundColor(Color(hex: "B69FD5"))
                        .padding(.horizontal)

                    HStack(spacing: 10) {
                        ForEach(1...5, id: \.self) { i in
                            Image(systemName: rating >= Double(i) ? "star.fill" :
                                    (rating >= Double(i) - 0.5 ? "star.leadinghalf.filled" : "star"))
                                .foregroundColor(.yellow)
                                .font(.title2)
                                .onTapGesture {
                                    rating = Double(i)
                                }
                                .contentShape(Rectangle())
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 5)

                    HStack {
                        Button(action: {
                            rating = max(0, rating - 0.5)
                        }) {
                            Text("-")
                                .font(.title2)
                                .foregroundColor(Color(hex: "6B4C8B"))
                                .frame(width: 36, height: 36)
                                .background(Color.white.opacity(0.85))
                                .clipShape(Capsule())
                                .overlay(
                                    Capsule()
                                        .stroke(Color(hex: "B69FD5"), lineWidth: 1.5)
                                )
                                .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                        }
                        .scaleEffect(pressedMinus ? 0.95 : 1)
                        .animation(.easeOut(duration: 0.2), value: pressedMinus)
                        .simultaneousGesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { _ in pressedMinus = true }
                                .onEnded { _ in pressedMinus = false }
                        )

                        Spacer()

                        Text("Rating: \(String(format: "%.1f", rating))")
                            .font(.headline)
                            .foregroundColor(Color(hex: "6B4C8B"))

                        Spacer()

                        Button(action: {
                            rating = min(5, rating + 0.5)
                        }) {
                            Text("+")
                                .font(.title2)
                                .foregroundColor(Color(hex: "6B4C8B"))
                                .frame(width: 36, height: 36)
                                .background(Color.white.opacity(0.85))
                                .clipShape(Capsule())
                                .overlay(
                                    Capsule()
                                        .stroke(Color(hex: "B69FD5"), lineWidth: 1.5)
                                )
                                .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                        }
                        .scaleEffect(pressedPlus ? 0.95 : 1)
                        .animation(.easeOut(duration: 0.2), value: pressedPlus)
                        .simultaneousGesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { _ in pressedPlus = true }
                                .onEnded { _ in pressedPlus = false }
                        )
                    }
                    .padding(.horizontal)

                    Divider()
                        .padding(.horizontal)

                    Text("Status")
                        .font(.system(.headline, design: .rounded).bold())
                        .tracking(1.2)
                        .foregroundColor(Color(hex: "B69FD5"))
                        .padding(.horizontal)

                    Picker("Status", selection: $status) {
                        ForEach(statuses, id: \.self) { option in
                            Text(option)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal)
                    .padding(.vertical, 6)

                    if status == "Read" {
                        Button(action: {
                            withAnimation {
                                writingReview = true
                            }
                        }) {
                            Text("Write a review...")
                                .font(.headline.bold())
                                .tracking(1.2)
                                .foregroundColor(.white)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 10)
                                .background(Color(hex: "B69FD5"))
                                .clipShape(Capsule())
                                .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 3)
                        }
                        .padding(.horizontal)
                        .padding(.top)
                        .scaleEffect(pressedWriteReview ? 0.95 : 1)
                        .animation(.easeOut(duration: 0.2), value: pressedWriteReview)
                        .simultaneousGesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { _ in pressedWriteReview = true }
                                .onEnded { _ in pressedWriteReview = false }
                        )
                    }

                    if writingReview {
                        Text("Review")
                            .font(.system(.headline, design: .rounded).bold())
                            .tracking(1.2)
                            .foregroundColor(Color(hex: "B69FD5"))
                            .padding(.horizontal)

                        ScrollView {
                            TextEditor(text: $review)
                                .frame(minHeight: 100, maxHeight: 200)
                                .padding()
                                .background(Color.white.opacity(0.85))
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(Color(hex: "B69FD5"), lineWidth: 1.5)
                                )
                                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                        }
                        .frame(height: 200)
                        .padding(.horizontal)
                    }

                    Button(action: {
                        let newBook = bookItem(title: title, rating: Float(rating), review: review, status: status)
                        onAdd(newBook)
                        dismiss()
                    }) {
                        Text("Add Book")
                            .font(.headline.bold())
                            .tracking(1.2)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .background(Color(hex: "B69FD5"))
                            .clipShape(Capsule())
                            .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 3)
                            .padding(.horizontal)
                            .padding(.top, 15)
                    }
                    .disabled(title.isEmpty)
                    .scaleEffect(pressedAdd ? 0.95 : 1)
                    .animation(.easeOut(duration: 0.2), value: pressedAdd)
                    .simultaneousGesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { _ in pressedAdd = true }
                            .onEnded { _ in pressedAdd = false }
                    )
                }
                .padding(.vertical)
                .background(Color.white.opacity(0.95))
                .cornerRadius(25)
                .shadow(color: Color.black.opacity(0.08), radius: 12, x: 0, y: 5)
                .padding(.horizontal)
                .padding(.top, 40)
                .padding(.bottom, 60)
            }

            Button(action: {
                dismiss()
            }) {
                Image(systemName: "xmark")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color(hex: "B69FD5"))
                    .clipShape(Circle())
                    .shadow(radius: 2)
                    .padding()
                    .scaleEffect(pressedDismiss ? 0.95 : 1)
                    .animation(.easeOut(duration: 0.2), value: pressedDismiss)
            }
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in pressedDismiss = true }
                    .onEnded { _ in pressedDismiss = false }
            )
        }
    }
}

#Preview {
    AddBookView { _ in }
}
