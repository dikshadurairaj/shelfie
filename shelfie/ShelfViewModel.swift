import FirebaseFirestore
import FirebaseAuth

class ShelfViewModel: ObservableObject {
    @Published var books: [bookItem] = []
    private var db = Firestore.firestore()

    func loadShelf() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        db.collection("users").document(uid).getDocument { snapshot, error in
            if let error = error {
                print("Failed to load shelf: \(error.localizedDescription)")
                return
            }
            guard let data = snapshot?.data(),
                  let booksArray = data["books"] as? [[String: Any]] else {
                print("No books found")
                return
            }

            self.books = booksArray.map { dict in
                bookItem(
                    title: dict["title"] as? String ?? "",
                    rating: dict["rating"] as? Float ?? 0,
                    review: dict["review"] as? String ?? "",
                    status: dict["status"] as? String ?? ""
                )
            }
        }
    }

    func saveShelf() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let booksData = books.map { book in
            [
                "title": book.title,
                "rating": book.rating,
                "review": book.review,
                "status": book.status
            ] as [String : Any]
        }

        db.collection("users").document(uid).setData([
            "name": Auth.auth().currentUser?.email ?? "No Name",
            "books": booksData
        ]) { error in
            if let error = error {
                print("Failed to save shelf: \(error.localizedDescription)")
            } else {
                print("Shelf saved successfully")
            }
        }
    }
}
