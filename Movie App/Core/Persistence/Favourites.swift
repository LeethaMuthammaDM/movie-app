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
    
    private let key = "favorite_movies"
    
    init() {
        load()
    }
    
    func toggleFavorite(movieId: Int) {
        if favoriteIds.contains(movieId) {
            favoriteIds.remove(movieId)
        } else {
            favoriteIds.insert(movieId)
        }
        save()
    }
    
    func isFavorite(movieId: Int) -> Bool {
        favoriteIds.contains(movieId)
    }
    
    private func save() {
        UserDefaults.standard.set(Array(favoriteIds), forKey: key)
    }
    
    private func load() {
        let ids = UserDefaults.standard.array(forKey: key) as? [Int] ?? []
        favoriteIds = Set(ids)
    }
}
