

import SwiftUI

struct WatchlistView: View {
    @EnvironmentObject var favoritesManager: FavoritesManager
    @StateObject private var viewModel = WatchlistViewModel()
    @State private var displayMode: DisplayMode = .list
    
    enum DisplayMode: String, CaseIterable, Identifiable {
        case list = "List"
        case grid = "Grid"
        
        var id: String { rawValue }
    }
    
    private let gridColumns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView()
            } else if viewModel.movies.isEmpty {
                EmptyStateView(message: "No movies saved")
            } else {
                content
            }
        }
        .navigationTitle("Watchlist")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Picker("Display", selection: $displayMode) {
                    ForEach(DisplayMode.allCases) { mode in
                        Text(mode.rawValue).tag(mode)
                    }
                }
                .pickerStyle(.segmented)
                .frame(width: 140)
            }
        }
        .onAppear {
            Task { await viewModel.loadMovies(from: favoritesManager) }
        }
        .onChange(of: favoritesManager.favoriteIds) { _, _ in
            Task { await viewModel.loadMovies(from: favoritesManager) }
        }
    }
    
    @ViewBuilder
    private var content: some View {
        switch displayMode {
        case .list:
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(viewModel.movies) { movie in
                        NavigationLink {
                            MovieDetailView(movie: movie)
                        } label: {
                            MovieRowView(movie: movie)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
            }
            
        case .grid:
            ScrollView {
                LazyVGrid(columns: gridColumns, spacing: 16) {
                    ForEach(viewModel.movies) { movie in
                        NavigationLink {
                            MovieDetailView(movie: movie)
                        } label: {
                            WatchlistGridCard(movie: movie)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
            }
        }
    }
}

private struct WatchlistGridCard: View {
    let movie: Movie
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            CachedAsyncImage(url: movie.posterURL, fallbackImage: AppConstants.posterFallbackImage)
                .frame(maxWidth: .infinity)
                .frame(height: 220)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .clipped()
            
            Text(movie.title)
                .font(.subheadline)
                .fontWeight(.semibold)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
            
            if let rating = movie.voteAverage {
                Text("⭐ \(rating, specifier: "%.1f")")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.08), radius: 5, x: 0, y: 2)
        )
    }
}
