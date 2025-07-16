import Foundation

var totalBooksCount = 0
var totalBooksRead = 0

class bookItem: Identifiable, ObservableObject {
    let id = UUID() //  This gives each book a unique ID

    @Published var title: String
    @Published var rating: Float
    @Published var review: String
    @Published var status: String
  
    init(title: String, rating: Float, review: String, status: String) {
        self.title = title
        self.rating = rating
        self.review = review
        self.status = status
    }
}

class UserProfile: Identifiable, ObservableObject {
    let id = UUID()

    @Published var name: String
    @Published var bio: String
    @Published var books: [bookItem]

    init(name: String, bio: String = "", books: [bookItem]) {
        self.name = name
        self.bio = bio
        self.books = books
    }
}
