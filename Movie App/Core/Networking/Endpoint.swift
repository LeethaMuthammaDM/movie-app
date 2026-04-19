//
//  Endpoint.swift
//  Movie App
//
//  Created by Leetha.dm on 18/04/26.
//

import Foundation

struct Endpoint {
    let path: String
    let queryItems: [URLQueryItem]

    var url: URL? {
        var components = URLComponents(string: Config.baseURL)
        components?.path += path
        components?.queryItems = queryItems
        return components?.url
    }
}

// MARK: - API Endpoints for P0pular, Details and Search
extension Endpoint {

    static func popular() -> Endpoint {
        Endpoint(
            path: "/movie/popular",
            queryItems: [
                URLQueryItem(name: "api_key", value: Config.apiKey)
            ]
        )
    }

    static func search(query: String) -> Endpoint {
        Endpoint(
            path: "/search/movie",
            queryItems: [
                URLQueryItem(name: "api_key", value: Config.apiKey),
                URLQueryItem(name: "query", value: query)
            ]
        )
    }


    static func fullDetails(movieId: Int) -> Endpoint {
        Endpoint(
            path: "/movie/\(movieId)",
            queryItems: [
                URLQueryItem(name: "api_key", value: Config.apiKey),
                URLQueryItem(name: "append_to_response", value: "videos,credits")
            ]
        )
    }
}
