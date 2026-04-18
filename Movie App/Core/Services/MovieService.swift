//
//  MovieService.swift
//  Movie App
//
//  Created by Leetha.dm on 18/04/26.
//

import Foundation

final class MovieService {
    
    func fetchPopular() async throws -> [Movie] {
        let endpoint = Endpoint(
            path: "/movie/popular",
            queryItems: [
                URLQueryItem(name: "api_key", value: Config.apiKey)
            ]
        )
        
        let response: MovieResponse = try await APIClient.shared.request(endpoint)
        return response.results
    }
    
    func search(query: String) async throws -> [Movie] {
        let endpoint = Endpoint(
            path: "/search/movie",
            queryItems: [
                URLQueryItem(name: "api_key", value: Config.apiKey),
                URLQueryItem(name: "query", value: query)
            ]
        )
        
        let response: MovieResponse = try await APIClient.shared.request(endpoint)
        return response.results
    }
    
    func fetchVideos(movieId: Int) async throws -> [Video] {
        let endpoint = Endpoint(
            path: "/movie/\(movieId)/videos",
            queryItems: [
                URLQueryItem(name: "api_key", value: Config.apiKey)
            ]
        )
        
        let response: VideoResponse = try await APIClient.shared.request(endpoint)
        return response.results
    }
    
    func fetchFullDetails(movieId: Int) async throws -> MovieDetailResponse {
        let endpoint = Endpoint.fullDetails(movieId: movieId)
        return try await APIClient.shared.request(endpoint)
    }
}
