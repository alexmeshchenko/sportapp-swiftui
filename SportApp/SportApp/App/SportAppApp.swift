//
//  SportAppApp.swift
//  SportApp
//
//  Created by Aleksandr Meshchenko on 30.08.25.
//

import SwiftUI

@main
struct SportApp: App {
    @StateObject private var store = Store()
    
    var body: some Scene {
        WindowGroup {
            ExerciseListView()
                .environmentObject(store)
        }
    }
}
