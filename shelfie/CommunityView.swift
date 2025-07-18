import SwiftUI

struct CommunityExploreView: View {
    // Later you can fetch real data, for now here's sample data
    let users: [UserProfile] = [
        UserProfile(name: "Sheldon", books: [bookItem(title: "Einstein + Quantum Physics", rating: 3.5, review: "", status: "Read")]),
        UserProfile(name: "Missy", books: [bookItem(title: "Baseball for Girls", rating: 5, review: "", status: "In progress")]),
        UserProfile(name: "Georgie", books: [bookItem(title: "Get Rich Quick", rating: 4.0, review: "", status: "Read")])
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
