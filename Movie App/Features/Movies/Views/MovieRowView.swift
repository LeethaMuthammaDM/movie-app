//
//  MovieRowView.swift
//  Movie App
//
//  Created by Leetha.dm on 18/04/26.
//

import SwiftUI

struct MovieRowView: View {
    @EnvironmentObject var favoritesManager: FavoritesManager
    let movie: Movie
    
    var body: some View {
        HStack(spacing: 12) {
            
            CachedAsyncImage(url: movie.posterURL, fallbackImage: AppConstants.posterFallbackImage)
                .frame(width: 90, height: 130)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .clipped()
            
            VStack(alignment: .leading, spacing: 6) {
                Text(movie.title)
                    .font(.headline)
                    .lineLimit(2)
                
                if let rating = movie.voteAverage {
                    Text("⭐ \(rating, specifier: "%.1f")")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
            
            Button {
                favoritesManager.toggleFavorite(movieId: movie.id)
            } label: {
                Image(systemName:
                        favoritesManager.isFavorite(movieId: movie.id)
                      ? AppConstants.notFavaouriteIcon
                      : AppConstants.favouriteIcon
                )
                .foregroundColor(.red)
                .font(.title3)
            }
            .buttonStyle(.plain)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.08), radius: 6, x: 0, y: 3)
        )
        .scaleEffect(0.98)
        .animation(.easeInOut, value: favoritesManager.favoriteIds)
    }
}
