import Foundation

class bookItem: Identifiable, ObservableObject {
    let id = UUID() // ✅ This gives each book a unique ID

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
