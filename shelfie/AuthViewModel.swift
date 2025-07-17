//
//  AuthViewModel.swift
//  shelfie
//
//  Created by Diksha Durairaj on 7/17/25.
//


import Foundation
import FirebaseAuth
import Combine

class AuthViewModel: ObservableObject {
    @Published var user: User? // Firebase user
    private var authStateListener: AuthStateDidChangeListenerHandle?

    init() {
        listenToAuthState()
    }

    func listenToAuthState() {
        authStateListener = Auth.auth().addStateDidChangeListener { _, user in
            self.user = user
        }
    }

    func signUp(email: String, password: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            self.user = result?.user
            completion(error)
        }
    }

    func signIn(email: String, password: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            self.user = result?.user
            completion(error)
        }
    }

    func signOut() {
        try? Auth.auth().signOut()
        self.user = nil
    }
}
