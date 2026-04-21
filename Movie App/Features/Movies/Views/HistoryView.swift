
import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var historyManager: HistoryManager
    @State private var showClearConfirmation = false
    
    private var historyItems: [HistoryMovie] {
        historyManager.getHistory()
    }
    
    var body: some View {
        Group {
            if historyItems.isEmpty {
                EmptyStateView(message: "No movies saved")
            } else {
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(historyItems) { item in
                            HistoryRowView(item: item)
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationTitle("History")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Clear History", role: .destructive) {
                    showClearConfirmation = true
                }
                .disabled(historyItems.isEmpty)
            }
        }
        .alert("Clear History?", isPresented: $showClearConfirmation) {
            Button("Cancel", role: .cancel) { }
            Button("Clear", role: .destructive) {
                historyManager.clearHistory()
            }
        } message: {
            Text("This will remove all recently viewed movies.")
        }
    }
}

private struct HistoryRowView: View {
    let item: HistoryMovie
    
    private var posterURL: URL? {
        guard let posterPath = item.posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
    }
    
    var body: some View {
        HStack(spacing: 12) {
            CachedAsyncImage(url: posterURL, fallbackImage: AppConstants.posterFallbackImage)
                .frame(width: 90, height: 130)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .clipped()
            
            VStack(alignment: .leading, spacing: 6) {
                Text(item.title)
                    .font(.headline)
                    .lineLimit(2)
                
                Text(item.viewedAt, style: .relative)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.08), radius: 6, x: 0, y: 3)
        )
        .scaleEffect(0.98)
    }
}
