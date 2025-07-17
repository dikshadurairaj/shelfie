import SwiftUI
import FirebaseFirestore

struct CommunityExploreView: View {
    @StateObject var viewModel = DiscoverViewModel()  // Use your ViewModel to fetch data
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(viewModel.users) { user in
                        VStack(alignment: .leading) {
                            Text(user.name)
                                .font(.headline)
                                .padding(.leading, 8)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(user.books) { book in
                                        VStack {
                                            RoundedRectangle(cornerRadius: 10)
                                                .fill(Color.purple.opacity(0.2))
                                                .frame(width: 100, height: 100)
                                                .overlay(
                                                    Text(book.title)
                                                        .font(.caption)
                                                        .multilineTextAlignment(.center)
                                                        .padding(5)
                                                )
                                            Text("⭐️ \(String(format: "%.1f", book.rating))")
                                                .font(.caption2)
                                        }
                                        .padding(4)
                                    }
                                }
                                .padding(.leading, 8)
                            }
                        }
                        .padding()
                        .background(Color(.systemGroupedBackground))
                        .cornerRadius(15)
                        .shadow(color: .black.opacity(0.05), radius: 3, x: 0, y: 2)
                    }
                }
                .padding()
            }
            .navigationTitle("Explore Shelves")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Back") {
                        dismiss()
                    }
                }
            }
            .onAppear {
                viewModel.fetchUsers()
            }
        }
    }
}

func fetchAllUsers(completion: @escaping ([UserProfile]) -> Void) {
    let db = Firestore.firestore()
    db.collection("users").getDocuments { snapshot, error in
        if let error = error {
            print("Error fetching users: \(error.localizedDescription)")
            completion([])
            return
        }

        let users = snapshot?.documents.compactMap { doc -> UserProfile? in
            let data = doc.data()
            guard let name = data["name"] as? String,
                  let booksArray = data["books"] as? [[String: Any]] else {
                return nil
            }

            let books = booksArray.map { dict in
                bookItem(
                    title: dict["title"] as? String ?? "",
                    rating: dict["rating"] as? Float ?? 0,
                    review: dict["review"] as? String ?? "",
                    status: dict["status"] as? String ?? ""
                )
            }

            return UserProfile(name: name, books: books)
        } ?? []

        completion(users)
    }
}
