//
//  CachedAsyncImage.swift
//  Movie App
//
//  Created by Leetha.dm on 18/04/26.
//

import SwiftUI

struct CachedAsyncImage: View {
    
    let url: URL?
    
    @State private var image: UIImage?
    @State private var isLoading = false
    let fallbackImage: String
    
    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else if isLoading {
                ProgressView()
            } else {
                fallbackView
            }
        }
        .onAppear {
            loadImage()
        }
    }
    
    private func loadImage(forceRefresh: Bool = false) {
        guard let url = url else { return }
        
        if !forceRefresh,
           let cached = ImageCache.shared.object(forKey: url as NSURL) {
            self.image = cached
            return
        }
        
        isLoading = true
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data,
                  let uiImage = UIImage(data: data) else {
                DispatchQueue.main.async {
                    self.isLoading = false
                }
                return
            }
            
            ImageCache.shared.setObject(uiImage, forKey: url as NSURL)
            
            DispatchQueue.main.async {
                self.image = uiImage
                self.isLoading = false
            }
        }.resume()
    }
    
    private var fallbackView: some View {
        ZStack {
            Color.gray.opacity(0.1)
            
            VStack {
                Image(systemName: fallbackImage)
                    .font(.title)
            }
            .foregroundColor(.gray)
        }
        .onTapGesture {
            loadImage(forceRefresh: true)
        }
    }
}
