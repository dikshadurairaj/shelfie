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
        ZStack {
            // Background gradient to match ShelfView
            LinearGradient(
                gradient: Gradient(colors: [Color(.systemGray6), .white]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 24) {
                Text("Welcome Back")
                    .font(.system(size: 32, weight: .semibold, design: .rounded))
                    .foregroundColor(.primary)
                    .padding(.top, 50)

                VStack(spacing: 16) {
                    TextField("Email", text: $email)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.white)
                                .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 3)
                        )
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)

                    SecureField("Password", text: $password)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.white)
                                .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 3)
                        )
                }
                .padding(.horizontal, 24)

                VStack(spacing: 14) {
                    Button(action: {
                        auth.logIn(email: email, password: password) { error in
                            if error == nil { onLoginSuccess() }
                            else { print("Login error: \(error!.localizedDescription)") }
                        }
                    }) {
                        Text("Log In")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.purple)
                            .cornerRadius(12)
                            .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
                    }

                    Button(action: {
                        auth.signUp(email: email, password: password) { error in
                            if error == nil { onLoginSuccess() }
                            else { print("Signup error: \(error!.localizedDescription)") }
                        }
                    }) {
                        Text("Sign Up")
                            .font(.headline)
                            .foregroundColor(.purple)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.purple.opacity(0.15))
                            .cornerRadius(12)
                    }
                }
                .padding(.horizontal, 24)

                Spacer()
            }
        }
    }
}

#Preview {
    LoginView(onLoginSuccess: { print("Logged in!") })
}
