//
//  BFinderApp.swift
//  BFinder
//
//  Created by Kevin Zmijewski on 8/8/25.
//

import SwiftUI

@main
struct BFinderApp: App {
    @StateObject private var favoritesManager = FavoritesManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(favoritesManager)
        }
    }
}
