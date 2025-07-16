//
//  GoalProgressView.swift
//  shelfie
//
//  Created by Harleen Monder on 2025-07-16.
//

import SwiftUI

struct GoalProgressView: View {
    @State private var goal: Int = 0
    @State private var booksRead: Int = 0
    @State private var showingSetGoal = false
    @Environment(\.dismiss) var dismiss

    var progress: Double {
        goal == 0 ? 0 : Double(booksRead) / Double(goal)
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                HStack {
                    Spacer()
                        Button(action: {dismiss()}) {
                                Image(systemName: "xmark")
                                    .foregroundColor(.black)
                                    .padding()
                                    .background(Color(.systemGray5))
                                    .clipShape(Circle())
                                }
                                .padding()
                            }
                Text("📚 Reading Challenge")
                    .font(.title2)
                    .bold()

                Text("You've read \(booksRead) of \(goal) books")
                    .font(.subheadline)
                    .foregroundColor(.gray)

                ProgressView(value: progress)
                    .progressViewStyle(LinearProgressViewStyle(tint: .purple))
                    .frame(width: 250)

                Text("\(Int(progress * 100))% complete")
                    .font(.caption)

                // Button to update the goal
                Button("Set Goal") {
                    showingSetGoal = true
                }
                .sheet(isPresented: $showingSetGoal) {
                    SetGoalView(currentGoal: $goal)
                }

                .padding(.top, 10)
                .foregroundColor(.blue)

                // Later, this will be triggered when a user marks a book finished in their reading list.

                Spacer()
                
            }
            .padding()
            .navigationTitle("Your Goal")
        }
    }
}



struct GoalProgressView_Previews: PreviewProvider {
    static var previews: some View {
        GoalProgressView()
    }
}
