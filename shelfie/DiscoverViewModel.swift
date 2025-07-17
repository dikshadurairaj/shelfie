//
//  DiscoverViewModel.swift
//  shelfie
//
//  Created by Diksha Durairaj on 7/17/25.
//


import FirebaseFirestore
import Combine

class DiscoverViewModel: ObservableObject {
    @Published var users: [UserProfile] = []

    func fetchUsers() {
        let db = Firestore.firestore()
        db.collection("users").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching users: \(error.localizedDescription)")
                return
            }
            guard let documents = snapshot?.documents else { return }

            // Parse users and books
            DispatchQueue.main.async {
                self.users = documents.compactMap { doc in
                    let data = doc.data()
                    guard let name = data["name"] as? String,
                          let booksArray = data["books"] as? [[String: Any]] else {
                              return nil
                          }

                    let books = booksArray.map { bookDict in
                        bookItem(
                            title: bookDict["title"] as? String ?? "",
                            rating: bookDict["rating"] as? Float ?? 0.0,
                            review: bookDict["review"] as? String ?? "",
                            status: bookDict["status"] as? String ?? ""
                        )
                    }

                    return UserProfile(name: name, books: books)
                }
            }
        }
    }
}
