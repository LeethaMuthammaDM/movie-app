//
//  MovieListViewModel.swift
//  Movie App
//
//  Created by Leetha.dm on 18/04/26.
//

import Foundation
import Combine

@MainActor
final class MovieListViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private var searchTask: Task<Void, Never>?
    private let service = MovieService()
    
    func loadMovies() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let apiMovies = try await service.fetchPopular()
            await MainActor.run {
                movies = apiMovies
            }

        } catch {
            print("API failed", error)
            errorMessage = AppConstants.unableToLoadData
        }
        
        isLoading = false
    }
    
    func search(query: String) {
        searchTask?.cancel()
        
        guard !query.isEmpty else {
            Task { await loadMovies() }
            return
        }
        
        searchTask = Task {
            try? await Task.sleep(nanoseconds: 300_000_000)
            
            if Task.isCancelled { return }
            
            do {
                let results = try await service.search(query: query)
                await MainActor.run {
                    self.movies = results
                    self.errorMessage = results.isEmpty ? AppConstants.noResultsFound : nil
                }
            } catch {
                await MainActor.run {
                    self.movies = []
                    self.errorMessage = AppConstants.offlineMessage
                }
            }
        }
    }
}
