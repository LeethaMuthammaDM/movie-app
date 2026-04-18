//
//  ImageCache.swift
//  Movie App
//
//  Created by Leetha.dm on 18/04/26.
//

import UIKit

final class ImageCache {
    static let shared = NSCache<NSURL, UIImage>()
}
