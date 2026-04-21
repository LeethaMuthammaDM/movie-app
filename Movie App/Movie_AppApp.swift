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
    @StateObject private var historyManager = HistoryManager()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                MovieListView()
                    .tabItem {
                        Label("Movies", systemImage: "film")
                    }
                
                NavigationStack {
                    WatchlistView()
                }
                .tabItem {
                    Label("Watchlist", systemImage: "heart.fill")
                }
            }
                .environmentObject(favoritesManager)
                .environmentObject(historyManager)
        }
    }
}
