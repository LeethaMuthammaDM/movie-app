//
//  Movie.swift
//  Movie App
//
//  Created by Leetha.dm on 18/04/26.
//

import Foundation
struct Movie: Decodable, Identifiable {
    let id: Int
        let title: String
        let overview: String
        let posterPath: String?
        let voteAverage: Double?
        let runtime: Int?


    var posterURL: URL? {
        guard let posterPath = posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
    }

    enum CodingKeys: String, CodingKey {
        case id, title, overview, runtime
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
    }
}
