//
//  messagingAppApp.swift
//  messagingApp
//
//  Created by 90308616 on 5/13/22.
//

import SwiftUI
import Firebase

@main
struct messagingAppApp: App {
    
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
