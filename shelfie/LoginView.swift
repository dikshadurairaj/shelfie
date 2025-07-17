import SwiftUI
import FirebaseAuth



class UserAuth: ObservableObject {
    @Published var isLoggedIn = false

    func logIn(email: String, password: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error == nil {
                DispatchQueue.main.async {
                    self.isLoggedIn = true
                }
            }
            completion(error)
        }
    }

    func signUp(email: String, password: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error == nil {
                DispatchQueue.main.async {
                    self.isLoggedIn = true
                }
            }
            completion(error)
        }
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
            isLoggedIn = false
        } catch {
            print("Sign out error: \(error.localizedDescription)")
        }
    }
}

struct LoginView: View {
    var onLoginSuccess: () -> Void
    @State private var email = ""
    @State private var password = ""
    @ObservedObject private var auth = UserAuth()

    var body: some View {
        VStack(spacing: 16) {
            Text("Login")
                .font(.largeTitle)

            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button("Log In") {
                auth.logIn(email: email, password: password) { error in
                    if error == nil {
                        onLoginSuccess()
                    } else {
                        print("Login error: \(error!.localizedDescription)")
                    }
                }
            }

            Button("Sign Up") {
                auth.signUp(email: email, password: password) { error in
                    if error == nil {
                        onLoginSuccess()
                    } else {
                        print("Signup error: \(error!.localizedDescription)")
                    }
                }
            }
        }
        .padding()
    }
}
