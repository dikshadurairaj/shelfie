import SwiftUI
struct ShelfItemView: View {
  @Binding var book: bookItem
  @Binding var books: [bookItem]
  @State private var showingEdit = false
  var body: some View {
    HStack {
      Rectangle()
        .fill(Color.pink.opacity(0.3))
        .frame(width: 50, height: 50)
        .cornerRadius(5)
      VStack(alignment: .leading) {
        Text(book.title)
          .font(.headline)
        Text("Rating: \(String(format: "%.1f", book.rating))")
          .font(.subheadline)
          .foregroundColor(.gray)
        Text("Status: \(book.status)")
          .font(.caption)
          .foregroundColor(.secondary)
      }
      Spacer()
      Button(action: {
        showingEdit = true
      }) {
        Image(systemName: "eye")
          .font(.system(size: 24))
          .foregroundColor(.primary)
      }
      .buttonStyle(.plain)
      .sheet(isPresented: $showingEdit) {
        editBookView(
          book: book,
          onSave: { updatedBook in
            self.book = updatedBook
            showingEdit = false
          },
          onDelete: { bookToDelete in
            if let index = books.firstIndex(where: { $0.id == bookToDelete.id }) {
              books.remove(at: index)
            }
            showingEdit = false
          }
        )
      }
    }
    .padding()
    .background(Color.brown.opacity(0.2))
    .cornerRadius(12)
  }
}














