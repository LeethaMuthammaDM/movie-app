//
//  extensions.swift
//  Movie App
//
//  Created by Leetha.dm on 18/04/26.
//

import Foundation

extension URL {
    static func youtubeWatchURL(for key: String) -> URL? {
        URL(string: "https://www.youtube.com/watch?v=\(key)")
    }
}
