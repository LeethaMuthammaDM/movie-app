//
//  MovieResponse.swift
//  Movie App
//
//  Created by Leetha.dm on 18/04/26.
//

import Foundation
struct MovieResponse: Decodable {
    let results: [Movie]
}
