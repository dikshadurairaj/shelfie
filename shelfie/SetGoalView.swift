//
//  SetGoalView.swift
//  shelfie
//
//  Created by Harleen Monder on 2025-07-16.
//

import SwiftUI

struct SetGoalView: View {
    @Binding var currentGoal: Int
    @Environment(\.presentationMode) var presentationMode
    @State private var newGoal: String = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("Set a Goal")
                .font(.title2)
                .bold()

            Text("How many books would you like to read this year?")
                .multilineTextAlignment(.center)

            TextField("Enter number", text: $newGoal)
                .keyboardType(.numberPad)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .frame(width: 200)

            Button("Save") {
                if let goal = Int(newGoal), goal > 0 {
                    currentGoal = goal
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .padding()
            .frame(width: 120)
            .background(Color.purple)
            .foregroundColor(.white)
            .cornerRadius(10)

            Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            }
            .foregroundColor(.gray)

            Spacer()
        }
        .padding()
        .onAppear {
            newGoal = "\(currentGoal)"
        }
    }
}


struct SetGoalView_Previews: PreviewProvider {
    static var previews: some View {
        // Create a dummy @State var and bind it with $
        SetGoalView(currentGoal: .constant(30))
        
    }
}


