//
//  Movie_AppApp.swift
//  Movie App
//
//  Created by Leetha.dm on 18/04/26.
//

import SwiftUI

@main
struct Movie_AppApp: App {
    @StateObject private var favoritesManager = FavoritesManager()
    
    var body: some Scene {
        WindowGroup {
           MovieListView()
                .environmentObject(favoritesManager)
        }
    }
}
