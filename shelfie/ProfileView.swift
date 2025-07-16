//
//  ProfileView.swift
//  shelfie
//
//  Created by Harleen Monder on 2025-07-16.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
    @AppStorage("userName") private var name: String = ""
    @AppStorage("userBio") private var bio: String = ""
    @AppStorage("userImageData") private var imageData: Data?

    @State private var selectedItem: PhotosPickerItem?
    @Environment(\.dismiss) var dismiss  // Allows view dismissal

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.purple.opacity(0.3), .white]),
                               startPoint: .top,
                               endPoint: .bottom)
                    .ignoresSafeArea()

                VStack(spacing: 25) {
                    // Profile Picture
                    ZStack {
                        if let data = imageData, let uiImage = UIImage(data: data) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                        } else {
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.gray.opacity(0.6))
                        }
                    }
                    .frame(width: 120, height: 120)
                    .background(Color.white)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.purple, lineWidth: 3))
                    .shadow(color: .purple.opacity(0.4), radius: 5)

                    // Image Picker
                    PhotosPicker("Choose Profile Picture", selection: $selectedItem, matching: .images)
                        .onChange(of: selectedItem) { _, newItem in
                            Task {
                                if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                    imageData = data
                                }
                            }
                        }
                        .foregroundColor(.purple)

                    // Name Field
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Name")
                            .font(.headline)
                            .foregroundColor(.gray)
                        TextField("Enter your name", text: $name)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(color: .gray.opacity(0.1), radius: 5)
                    }
                    .padding(.horizontal)

                    // Bio Editor
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Bio")
                            .font(.headline)
                            .foregroundColor(.gray)
                        TextEditor(text: $bio)
                            .frame(height: 100)
                            .padding(10)
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(color: .gray.opacity(0.1), radius: 5)
                    }
                    .padding(.horizontal)

                    Spacer()

                    // Save & Go Back
                    Button(action: {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        dismiss() // Go back to ContentView
                    }) {
                        Text("Save Changes")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.purple)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                }
                .padding(.top)
            }
            .navigationTitle("Your Profile")
        }
    }
}


#Preview {
    ProfileView()
}
