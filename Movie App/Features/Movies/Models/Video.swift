//
//  Video.swift
//  Movie App
//
//  Created by Leetha.dm on 18/04/26.
//

import Foundation
struct VideoResponse: Decodable {
    let results: [Video]
}

struct Video: Decodable {
    let key: String
    let site: String
    let type: String
}
