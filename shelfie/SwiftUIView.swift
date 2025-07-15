import SwiftUI

struct ShelfItemView: View {
    var book: bookItem

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

            Image(systemName: "eye")
        }
        .padding()
        .background(Color.brown.opacity(0.2))
        .cornerRadius(12)
    }
}
