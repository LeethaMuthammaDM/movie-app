//
//  MovieInfoView.swift
//  Movie App
//
//  Created by Leetha.dm on 18/04/26.
//

import SwiftUI

struct MovieHeaderView: View {
    let title: String
    let rating: Double?
    let runtime: Int?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.title)
                .bold()
            
            HStack {
                if let rating = rating {
                    Text("⭐ \(rating, specifier: "%.1f")")
                }
                
                if let runtime = runtime {
                    Text("⏱ \(runtime) min")
                }
            }
            .font(.subheadline)
            .foregroundColor(.secondary)
        }
    }
}
