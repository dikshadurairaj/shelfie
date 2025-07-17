//
//  shelfieApp.swift
//  shelfie
//
//  Created by Diksha Durairaj on 7/15/25.
//

import SwiftUI
import Firebase

@main
struct shelfieApp: App {
    
    init () {
        FirebaseApp.configure()
    
    }
    
    var body: some Scene {
        WindowGroup {
            ShelfView()
        }
    }
}
