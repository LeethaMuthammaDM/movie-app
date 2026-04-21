//
//  Favourites.swift
//  Movie App
//
//  Created by Leetha.dm on 18/04/26.
//

import Foundation
import Combine

final class FavoritesManager: ObservableObject {
    
    @Published private(set) var favoriteIds: Set<Int> = []
    
    private let favoritesKey = AppConstants.favoritesKey
    
    init() {
        load()
    }
    
    func toggleFavorite(movieId: Int) {
        if isFavorite(movieId: movieId) {
            remove(movieId: movieId)
        } else {
            add(movieId: movieId)
        }
    }
    
    func add(movie: Movie) {
        add(movieId: movie.id)
    }
    
    private func add(movieId: Int) {
        favoriteIds.insert(movieId)
        save()
    }
    
    func remove(movieId: Int) {
        favoriteIds.remove(movieId)
        save()
    }
    
    func isFavorite(movieId: Int) -> Bool {
        favoriteIds.contains(movieId)
    }
    
    func getAllFavorites() -> [Int] {
        Array(favoriteIds)
    }
    
    func addToWatchlist(movie: Movie) {
        add(movie: movie)
    }
    
    func removeFromWatchlist(movieId: Int) {
        remove(movieId: movieId)
    }
    
    func isInWatchlist(movieId: Int) -> Bool {
        isFavorite(movieId: movieId)
    }
    
    private func save() {
        UserDefaults.standard.set(Array(favoriteIds), forKey: favoritesKey)
    }
    
    private func load() {
        let ids = UserDefaults.standard.array(forKey: favoritesKey) as? [Int] ?? []
        favoriteIds = Set(ids)
    }
}
