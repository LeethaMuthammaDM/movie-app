//
//  APIClient.swift
//  Movie App
//
//  Created by Leetha.dm on 18/04/26.
//

import Foundation
final class APIClient {
    static let shared = APIClient()
    private init() {}

    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        guard let url = endpoint.url else {
            throw URLError(.badURL)
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let http = response as? HTTPURLResponse,
              200...299 ~= http.statusCode else {
            throw URLError(.badServerResponse)
        }

        let decoder = JSONDecoder()

        return try decoder.decode(T.self, from: data)
    }
}
