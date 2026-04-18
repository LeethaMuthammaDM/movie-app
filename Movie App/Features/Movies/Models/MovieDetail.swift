//
//  MovieDetail.swift
//  Movie App
//
//  Created by Leetha.dm on 18/04/26.
//

import Foundation
struct MovieDetail: Decodable {
    let id: Int
    let title: String
    let overview: String
    let runtime: Int?
    let voteAverage: Double?
    let genres: [Genre]
    let backdropPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview, runtime, genres
        case voteAverage = "vote_average"
        case backdropPath = "backdrop_path"
    }
}

struct Genre: Decodable {
    let id: Int
    let name: String
}


