import SwiftUI

struct AddBookView: View {
    @Environment(\.dismiss) var dismiss

    @State private var title = ""
    @State public var rating = 0.0
    @State private var status = "Want to read"

    var onAdd: (bookItem) -> Void

    let statuses = ["Want to read", "In progress", "Read"]

    var body: some View {
        VStack(spacing: 20) {
            // Title Input
            Text("Book Title:")
                .font(.title2)
                .fontWeight(.bold)

            TextField("Type book name...", text: $title)
                .padding()
                .background(Color(.systemGroupedBackground))
                .cornerRadius(15)

            // Star Rating Display
            HStack {
                ForEach(1...5, id: \.self) { i in
                    Image(systemName: rating >= Double(i) ? "star.fill" :
                            (rating >= Double(i) - 0.5 ? "star.leadinghalf.filled" : "star"))
                        .foregroundColor(.yellow)
                }
            }

            // Rating Adjust
            HStack {
                Button("-") {
                    rating = max(0, rating - 0.5)
                }

                Spacer()

                Text("Rating: \(String(format: "%.1f", rating))")

                Spacer()

                Button("+") {
                    rating = min(5, rating + 0.5)
                }
            }
            .padding(.horizontal, 50)

            // Status Picker
            Picker("Status", selection: $status) {
                ForEach(statuses, id: \.self) { option in
                    Text(option)
                }
            }
            .pickerStyle(.segmented)

            // Add Button
            Button("Add Book") {
                let newBook = bookItem(title: title, rating: Float(rating), review: "", status: status)
                onAdd(newBook)
                dismiss()
            }
            .disabled(title.isEmpty)
            .font(.title3)
            .fontWeight(.bold)
            .padding(.top, 20)
        }
        .padding()
    }
}
