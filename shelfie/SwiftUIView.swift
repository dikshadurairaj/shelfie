//
//  SwiftUIView.swift
//  shelfie
//
//  Created by Diksha Durairaj on 7/15/25.
//

import SwiftUI

struct ShelfItemView: View {
    var body: some View {
        HStack {
            Rectangle()
                .fill(Color.pink.opacity(0.3))
                .frame(width: 50, height: 50)
                .cornerRadius(5)

            Text("Add a subheading")
                .font(.headline)

            Spacer()

            Image(systemName: "eye")
        }
        .padding()
        .background(Color.brown.opacity(0.2))
        .cornerRadius(12)
    }
}

#Preview {
    ShelfItemView()
}
