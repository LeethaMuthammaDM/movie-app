//
//  MovieDetailViewModel.swift
//  Movie App
//
//  Created by Leetha.dm on 18/04/26.
//

import Foundation
import Combine

@MainActor
final class MovieDetailViewModel: ObservableObject {
    
    @Published var detail: MovieDetailResponse?
    @Published var trailerKey: String?
    @Published var isLoading = false
    
    private let service = MovieService()
    
    let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    func load() async {
        isLoading = true
        
        do {
            let response = try await service.fetchFullDetails(movieId: movie.id)
            detail = response
            
            trailerKey = extractTrailer(from: response.videos.results)
            
        } catch {
            print("Failed to load details:", error)
        }
        
        isLoading = false
    }
    
    private func extractTrailer(from videos: [Video]) -> String? {
        videos.first(where: {
            $0.type == AppConstants.trailer && $0.site == AppConstants.youtube
        })?.key
    }
}
