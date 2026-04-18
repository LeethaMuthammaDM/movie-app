//
//  CreditsResponse.swift
//  Movie App
//
//  Created by Leetha.dm on 18/04/26.
//

import Foundation
struct CreditsResponse: Decodable {
    let cast: [Cast]
}

struct Cast: Decodable, Identifiable {
    let id: Int
    let name: String
    let character: String
    let profilePath: String?

    var profileURL: URL? {
        guard let path = profilePath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w200\(path)")
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name, character
        case profilePath = "profile_path"
    }
}
