import SwiftUI

struct ShelfView: View {
    @State private var showingAddBook = false
    @State private var books: [bookItem] = []
    @State private var showingGoalView = false
    @State private var showingCommunityView = false
    @AppStorage("userImageData") private var imageData: Data?
    @AppStorage("userName") private var userName: String = ""

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color(.systemGray6), .white]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                VStack(spacing: 0) {
                    HStack {
                        Text(userName.isEmpty ? "My Shelf" : "\(userName)’s Shelf")
                            .font(.system(size: 26, weight: .semibold, design: .rounded))
                            .foregroundColor(.primary)

                        Spacer()

                        Button(action: { showingAddBook = true }) {
                            Image(systemName: "plus")
                                .font(.title2)
                                .padding(10)
                                .background(Color.purple.opacity(0.15))
                                .foregroundColor(.purple)
                                .clipShape(Circle())
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 20)

                    if books.isEmpty {
                        Spacer()
                        VStack(spacing: 14) {
                            Image(systemName: "books.vertical.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 120, height: 120)
                                .foregroundColor(.purple.opacity(0.3))

                            Text("Your shelf is empty.")
                                .font(.headline)
                                .foregroundColor(.gray)

                            Text("Tap the + to add your first book!")
                                .font(.subheadline)
                                .foregroundColor(.gray.opacity(0.8))
                        }
                        .multilineTextAlignment(.center)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color.white)
                                .shadow(color: .black.opacity(0.05), radius: 6, x: 0, y: 3)
                        )
                        .padding(.horizontal, 32)
                        Spacer()
                    } else {
                        ScrollView {
                            LazyVStack(spacing: 16) {
                                ForEach($books) { book in
                                    ShelfItemView(book: book, books: $books)
                                        .padding()
                                        .background(
                                            RoundedRectangle(cornerRadius: 20)
                                                .fill(Color.white)
                                                .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 3)
                                        )
                                }
                            }
                            .padding(.horizontal)
                            .padding(.top, 10)
                            .padding(.bottom, 20)
                        }
                    }

                    HStack {
                        Spacer()

                        Button(action: { showingCommunityView = true }) {
                            Image(systemName: "person.3.fill")
                                .foregroundColor(.purple)
                        }
                        .sheet(isPresented: $showingCommunityView) {
                            CommunityExploreView()
                        }

                        Spacer()

                        Button(action: { showingGoalView = true }) {
                            Image(systemName: "target")
                                .foregroundColor(.purple)
                        }

                        Spacer()

                        NavigationLink(destination: ProfileView()) {
                            if let data = imageData, let uiImage = UIImage(data: data) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 28, height: 28)
                                    .clipShape(Circle())
                            } else {
                                Image(systemName: "person.crop.circle")
                                    .foregroundColor(.purple)
                            }
                        }

                        Spacer()
                    }
                    .font(.title2)
                    .padding()
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                    .shadow(color: .black.opacity(0.04), radius: 4, x: 0, y: 2)
                    .fullScreenCover(isPresented: $showingGoalView) {
                        GoalProgressView()
                    }
                }
                .sheet(isPresented: $showingAddBook) {
                    AddBookView { newBook in
                        books.append(newBook)
                        totalBooksCount += 1
                        if newBook.status == "Read" {
                            totalBooksRead += 1
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ShelfView()
}
