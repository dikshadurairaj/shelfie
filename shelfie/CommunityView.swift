import SwiftUI

struct CommunityExploreView: View {
    // Later use real data from firebase, but rn i just hard coded fake names and stuff
    let users: [UserProfile] = [
        UserProfile(name: "Georgie", books: [bookItem(title: "Dune", rating: 4.5, review: "", status: "Read")]),
        UserProfile(name: "Sheldon", books: [bookItem(title: "Atomic Habits", rating: 5, review: "", status: "In progress")]),
        UserProfile(name: "Missy", books: [bookItem(title: "Circe", rating: 4.0, review: "", status: "Read")])
    ]

    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(users) { user in
                        VStack(alignment: .leading) {
                            Text(user.name)
                                .font(.headline)
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
                            }
                        }
                        .padding()
                        .background(Color(.systemGroupedBackground))
                        .cornerRadius(15)
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
        }
    }
}
