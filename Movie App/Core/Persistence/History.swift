

import Foundation
import Combine

struct HistoryMovie: Codable, Identifiable, Equatable {
    let id: Int
    var title: String
    var posterPath: String?
    var viewedAt: Date
}

final class HistoryManager: ObservableObject {
    
    @Published private(set) var historyItems: [HistoryMovie] = []
    
    private let key = AppConstants.historyKey
    private let maxItems = 20
    
    init() {
        load()
    }
    
    func addToHistory(movie: Movie) {
        if let index = historyItems.firstIndex(where: { $0.id == movie.id }) {
            historyItems[index].title = movie.title
            historyItems[index].posterPath = movie.posterPath
            historyItems[index].viewedAt = Date()
        } else {
            historyItems.append(
                HistoryMovie(
                    id: movie.id,
                    title: movie.title,
                    posterPath: movie.posterPath,
                    viewedAt: Date()
                )
            )
        }
        
        historyItems = Array(historyItems.sorted(by: { $0.viewedAt > $1.viewedAt }).prefix(maxItems))
        save()
    }
    
    func getHistory() -> [HistoryMovie] {
        historyItems.sorted(by: { $0.viewedAt > $1.viewedAt })
    }
    
    func clearHistory() {
        historyItems = []
        save()
    }
    
    private func save() {
        do {
            let data = try JSONEncoder().encode(historyItems)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            return
        }
    }
    
    private func load() {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            historyItems = []
            return
        }
        
        do {
            let decoded = try JSONDecoder().decode([HistoryMovie].self, from: data)
            historyItems = Array(decoded.sorted(by: { $0.viewedAt > $1.viewedAt }).prefix(maxItems))
        } catch {
            historyItems = []
        }
    }
}
