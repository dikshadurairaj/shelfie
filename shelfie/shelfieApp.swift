import SwiftUI
import Firebase

@main
struct ShelfieApp: App {
    @StateObject var auth = UserAuth()

    init() {
        FirebaseApp.configure() 
    }

    var body: some Scene {
        WindowGroup {
            AuthenticationRootView()
                .environmentObject(auth)
        }
    }
}
