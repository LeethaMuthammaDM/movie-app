//
//  MovieListView.swift
//  Movie App
//
//  Created by Leetha.dm on 18/04/26.
//

import Foundation
import SwiftUI

struct MovieListView: View {
    @StateObject private var viewModel = MovieListViewModel()
    @State private var searchText = ""
    @StateObject private var network = NetworkManager.shared

    var body: some View {
        NavigationStack {
            VStack {
                if !network.isConnected {
                    EmptyStateView(message: AppConstants.offlineMode)

                } else if viewModel.isLoading {
                    ProgressView()

                } else if viewModel.movies.isEmpty {
                    EmptyStateView(message: viewModel.errorMessage ?? AppConstants.noResultsFound)

                } else {
                    movieList
                }
            }
            .searchable(text: $searchText, prompt: AppConstants.searchPlaceholder)
            .onChange(of: searchText) { _, newValue in
                viewModel.search(query: newValue)
            }
            .onChange(of: network.isConnected) { _, isConnected in
                if isConnected && viewModel.movies.isEmpty {
                    Task { await viewModel.loadMovies() }
                }
            }
            .task {
                await viewModel.loadMovies()
            }
            .navigationTitle(AppConstants.movies)
            .refreshable {
                await viewModel.loadMovies()
            }
        }
    }

    @ViewBuilder
    private var movieList: some View {
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
    }
}
