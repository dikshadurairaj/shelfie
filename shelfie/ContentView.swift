import SwiftUI

struct ShelfView: View {
    var body: some View {
        VStack {
            // Top Bar
            HStack {
                Text("Diksha’s Shelf")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
                Button(action: {
                    // Add book action
                }) {
                    Image(systemName: "plus")
                        .font(.title)
                }
            }
            .padding()

            // Shelf List
            ScrollView {
                VStack(spacing: 15) {
                    ForEach(0..<4) { _ in
                        ShelfItemView()
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
    }
}


#Preview {
    ShelfView()
}
