//
//  MovieDetailView.swift
//  Movie App
//
//  Created by Leetha.dm on 18/04/26.
//

import SwiftUI

struct MovieDetailView: View {
    @EnvironmentObject var favoritesManager: FavoritesManager
    @EnvironmentObject var historyManager: HistoryManager
    @StateObject private var viewModel: MovieDetailViewModel
    @State private var isPlayerLoading = true
    
    init(movie: Movie) {
        _viewModel = StateObject(wrappedValue: MovieDetailViewModel(movie: movie))
    }
    
    var body: some View {
        
        ScrollView {
            
            if viewModel.isLoading {
                ProgressView()
                    .padding()
            } else if let detail = viewModel.detail {
                
                VStack(alignment: .leading, spacing: 16) {
                    
                    TrailerSectionView(
                        trailerKey: viewModel.trailerKey,
                        isLoading: $isPlayerLoading
                    )
                    
                    MovieHeaderView(
                        title: detail.title,
                        rating: detail.voteAverage,
                        runtime: detail.runtime
                    )
                    
                    GenreSectionView(
                        genres: detail.genres
                    )
                    
                    Text(detail.overview)
                        .font(.body)
                    
                    CastSectionView(cast: detail.credits.cast)
                }
                .padding()
            }
        }
        .refreshable {
            await viewModel.load()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    favoritesManager.toggleFavorite(movieId: viewModel.movie.id)
                } label: {
                    
                    let isFavourite =  favoritesManager.isFavorite(movieId: viewModel.movie.id)
                    Image(systemName:
                            isFavourite
                          ? AppConstants.notFavaouriteIcon
                          : AppConstants.favouriteIcon
                    )
                    .foregroundColor(.red)
                    .scaleEffect(isFavourite ? 1.2 : 1.0)
                    .animation(.spring(), value: isFavourite)
                }
            }
        }
        .navigationTitle(AppConstants.details)
        .onAppear {
            historyManager.addToHistory(movie: viewModel.movie)
        }
        .task {
            await viewModel.load()
        }
    }
}
