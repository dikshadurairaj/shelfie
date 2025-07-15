import SwiftUI

struct ShelfView: View {
    @State private var showingAddBook = false
    @State private var books: [bookItem] = []

    var body: some View {
        VStack {
            // Top Bar
            HStack {
                Text("Diksha’s Shelf")
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
                    ForEach(books) { book in
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
                Image(systemName: "target")
                Spacer()
                Image(systemName: "person.crop.circle")
                Spacer()
            }
            .font(.title2)
            .padding()
            .background(Color.white.shadow(radius: 2))
        }
        // add one sheet modifier with AddBookView
        .sheet(isPresented: $showingAddBook) {
            AddBookView { newBook in
                books.append(newBook)
            }
        }
    }
}

#Preview {
    ShelfView()
}
