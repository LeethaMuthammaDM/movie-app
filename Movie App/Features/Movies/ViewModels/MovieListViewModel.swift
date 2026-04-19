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
    @Published var viewState: ViewState = .loading 
    
    private var searchTask: Task<Void, Never>?
    private let service = MovieService()

    func loadMovies() async {
        viewState = .loading

        do {
            let apiMovies = try await service.fetchPopular()
            movies = apiMovies
            viewState = movies.isEmpty ? .empty(AppConstants.noResultsFound) : .success
        } catch {
            viewState = .empty(AppConstants.unableToLoadData)
        }
    }

    func search(query: String) {
        searchTask?.cancel()

        guard !query.isEmpty else {
            Task { await loadMovies() }
            return
        }

        searchTask = Task {
            try? await Task.sleep(nanoseconds: 300_000_000)
            guard !Task.isCancelled else { return }

            do {
                let results = try await service.search(query: query)
                movies = results
                viewState = results.isEmpty ? .empty(AppConstants.noResultsFound) : .success
            } catch {
                movies = []
                viewState = .empty(AppConstants.unableToLoadData)
            }
        }
    }
}

enum ViewState {
    case loading
    case success
    case empty(String)
    case offline
}
