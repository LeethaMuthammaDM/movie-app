//
//  AppConstants.swift
//  Movie App
//
//  Created by Leetha.dm on 18/04/26.
//


enum AppConstants {
    
    // MARK: - UserDefaults Keys
    static let favoritesKey = "favorite_movies"
    static let watchlistKey = "watchlist_movies"
    static let historyKey = "recently_viewed_movies"
    
    // MARK: - Strings
    static let appTitle = "Movie App"
    static let movies = "Movies"
    static let offlineMode = "Offline mode"
    static let noMovies = "No movies found"
    static let searchPlaceholder = "Search movies"
    static let trailer = "Trailer"
    static let trailerUnavailable = "Trailer not available"
    static let noInternet = "No internet connection"
    static let watchOnYouTube = "Watch on YouTube"
    static let cast = "Cast"
    static let details = "Details"
    static let youtube = "YouTube"
    static let loadMoviesFailed = "Failed to load movies"
    static let anErrorOccurred = "An Error Occured"
    static let noResultsFound = "No results found"
    static let offlineMessage = "You're offline"
    static let unableToLoadData = "Unable to load movies"
    
    
    
    // MARK: - Image Labels
    static let castFallbackImage = "person.fill"
    static let emptyFallbackImage = "film"
    static let posterFallbackImage = "photo"
    static let notFavaouriteIcon = "heart.fill"
    static let favouriteIcon = "heart"
    static let noTrailerImage = "play.slash"
    
    // MARK: - Queue Label
    static let networkQueueLabel = "NetworkManager"
    
    // MARK: - Config Label
    static let apiKeyLabel = "api_key"
    static let queryLabel = "query"
    
    
}
