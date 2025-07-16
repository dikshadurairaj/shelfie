import SwiftUI

struct ShelfView: View {
    @State private var showingAddBook = false
    @State private var books: [bookItem] = []
    @State private var showingGoalView = false
    @AppStorage("userImageData") private var imageData: Data?
    @AppStorage("userName") private var userName: String = ""

    var body: some View {
        NavigationView {
            VStack {
                // Top Bar
                HStack {
                    Text(nameToDisplay())
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                    Button(action: {
                        showingAddBook = true
                    }) {
                        Image(systemName: "plus")
                            .font(.title)
                    }
                }
                .padding()

                // Shelf List
                ScrollView {
                    VStack(spacing: 15) {
                        ForEach($books) { book in
                            ShelfItemView(book: book)
                        }
                    }
                    .padding()
                }

                Spacer()

                // Bottom Navigation Bar
                HStack {
                    Spacer()
                    Image(systemName: "person.3.fill")
                    Spacer()
                    Button(action: {
                        showingGoalView = true
                    }) {
                        Image(systemName: "target")
                    }
                    Spacer()
                    NavigationLink(destination: ProfileView()) {
                        if let data = imageData, let uiImage = UIImage(data: data) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 30, height: 30)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.purple, lineWidth: 1))
                        } else {
                            Image(systemName: "person.crop.circle")
                        }
                    }
                    Spacer()
                }
                .font(.title2)
                .padding()
                .background(Color.white.shadow(radius: 2))
                .fullScreenCover(isPresented: $showingGoalView) {
                    GoalProgressView()
                }
            }
            .sheet(isPresented: $showingAddBook) {
                AddBookView { newBook in
                    books.append(newBook)
                }
            }
        }
    }
    func nameToDisplay() -> String {
        return userName.isEmpty ? "Your Shelf" : "\(userName)’s Shelf"
    }
}

#Preview {
    ShelfView()
}

