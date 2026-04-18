//
//  TrailerSectionView.swift
//  Movie App
//
//  Created by Leetha.dm on 18/04/26.
//

import SwiftUI

struct TrailerSectionView: View {
    
    let trailerKey: String?
    @Binding var isLoading: Bool
    @StateObject private var network = NetworkManager.shared
    @State private var hasError = false
    
    var body: some View {
        
        if let key = trailerKey {
            let url = URL.youtubeWatchURL(for: key)
            
            VStack(alignment: .leading) {
                Text(AppConstants.trailer)
                    .font(.headline)
                
                 ZStack {
                    if !network.isConnected {
                        TrailerErrorView(message: AppConstants.offlineMode)
                    }else {
                        if isLoading {
                            ProgressView()
                        }
                        YouTubePlayerView(videoID: key, isLoading: $isLoading, hasError: $hasError)
                            .frame(height: 220)
                            .cornerRadius(12)
                    }
                    
                }
                if let url = url {
                    Button(AppConstants.watchOnYouTube) {
                        UIApplication.shared.open(url)
                    }
                    .font(.caption)
                    .foregroundColor(.red)
                }
            }
        } else {
            TrailerErrorView(message: AppConstants.trailerUnavailable)
        }
    }
    
}

