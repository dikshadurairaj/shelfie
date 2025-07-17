import SwiftUI
import FirebaseAuth

struct AuthenticationRootView: View {
    @State private var isUserLoggedIn = Auth.auth().currentUser != nil

    var body: some View {
        VStack {
            if isUserLoggedIn {
                ShelfView()
            } else {
                LoginView(onLoginSuccess: {
                    self.isUserLoggedIn = true
                })
            }
        }
        .onAppear {
            self.isUserLoggedIn = Auth.auth().currentUser != nil
        }
    }
}
