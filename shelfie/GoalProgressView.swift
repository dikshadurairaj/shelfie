//
//  GoalProgressView.swift
//  shelfie
//
//  Created by Harleen Monder on 2025-07-16.
//

import SwiftUI

struct GoalProgressView: View {
    @AppStorage("readingGoal") private var goal: Int = 0
    @State private var booksRead: Int = totalBooksRead
    @State private var showingSetGoal = false
    @Environment(\.dismiss) var dismiss

    var progress: Double {
        goal == 0 ? 0 : Double(booksRead) / Double(goal)
    }

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color(hex: "F4DAF9"), Color(hex: "FFECE9")]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                VStack(spacing: 25) {
                    HStack(alignment: .center) {
                        Text("Your Goal")
                            .font(.system(size: 36, weight: .bold, design: .rounded))
                            .foregroundColor(Color(hex: "6B4C8B"))

                        Spacer()

                        Button(action: { dismiss() }) {
                            Image(systemName: "xmark")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color(hex: "B69FD5"))
                                .clipShape(Circle())
                                .shadow(radius: 2)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 20)

                    Spacer().frame(height: 80)

                    VStack(spacing: 25) {
                        Text("Reading Challenge")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(Color(hex: "B69FD5"))
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .background(Color.white.opacity(0.8))
                            .clipShape(Capsule())
                            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)

                        Text("You've read \(booksRead) of \(goal) books")
                            .font(.subheadline)
                            .foregroundColor(.black.opacity(0.8))

                        ProgressView(value: progress)
                            .progressViewStyle(LinearProgressViewStyle(tint: Color(hex: "B69FD5")))
                            .frame(width: 250)

                        Text("\(Int(progress * 100))% complete")
                            .font(.caption)
                            .foregroundColor(.black.opacity(0.7))

                        Button("Set Goal") {
                            showingSetGoal = true
                        }
                        .sheet(isPresented: $showingSetGoal) {
                            SetGoalView(currentGoal: $goal)
                        }
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 10)
                        .background(Color(hex: "B69FD5"))
                        .cornerRadius(14)
                        .shadow(radius: 2)
                    }

                    Spacer()
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color(hex: "B69FD5"), lineWidth: 4)
                        .background(Color.white.opacity(0.4))
                        .cornerRadius(20)
                )
                .padding(20)
            }
            .navigationBarHidden(true)
        }
    }
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)

        let r = Double((rgb >> 16) & 0xFF) / 255
        let g = Double((rgb >> 8) & 0xFF) / 255
        let b = Double(rgb & 0xFF) / 255

        self.init(red: r, green: g, blue: b)
    }
}

struct GoalProgressView_Previews: PreviewProvider {
    static var previews: some View {
        GoalProgressView()
    }
}
