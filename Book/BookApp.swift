//
//  BookApp.swift
//  Book
//
//  Created by Tom on 10/02/2022.
//

import SwiftUI
import Firebase

@main
struct BookApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
