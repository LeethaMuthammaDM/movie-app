//
//  MovieDetailResponse.swift
//  Movie App
//
//  Created by Leetha.dm on 18/04/26.
//

import Foundation
struct MovieDetailResponse: Decodable {
    let id: Int
    let title: String
    let overview: String
    let runtime: Int?
    let voteAverage: Double?
    let genres: [Genre]
    let backdropPath: String?

    let videos: VideoResponse
    let credits: CreditsResponse

    enum CodingKeys: String, CodingKey {
        case id, title, overview, runtime, genres, videos, credits
        case voteAverage = "vote_average"
        case backdropPath = "backdrop_path"
    }
}
