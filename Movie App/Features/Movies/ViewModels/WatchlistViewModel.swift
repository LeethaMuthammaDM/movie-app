
import Foundation
import Combine

@MainActor
final class WatchlistViewModel: ObservableObject {
    
    @Published var movies: [Movie] = []
    @Published var isLoading = false
    
    private let service = MovieService()
    
    func loadMovies(from favoritesManager: FavoritesManager) async {
        let movieIds = favoritesManager.getAllFavorites()
        
        guard !movieIds.isEmpty else {
            movies = []
            return
        }
        
        isLoading = true
        defer { isLoading = false }
        
        var loadedMovies: [Movie] = []
        
        await withTaskGroup(of: Movie?.self) { group in
            for id in movieIds {
                group.addTask { [service] in
                    try? await service.fetchMovie(movieId: id)
                }
            }
            
            for await movie in group {
                if let movie {
                    loadedMovies.append(movie)
                }
            }
        }
        
        let orderMap = Dictionary(uniqueKeysWithValues: movieIds.enumerated().map { ($0.element, $0.offset) })
        movies = loadedMovies.sorted {
            (orderMap[$0.id] ?? Int.max) < (orderMap[$1.id] ?? Int.max)
        }
    }
}
