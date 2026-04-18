//
//  GenreSectionView.swift
//  Movie App
//
//  Created by Leetha.dm on 18/04/26.
//

import SwiftUI

struct GenreSectionView: View {
    let genres: [Genre]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(genres, id: \.id) { genre in
                    Text(genre.name)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(Color.blue.opacity(0.1))
                        .foregroundColor(.blue)
                        .cornerRadius(12)
                }
            }
        }
    }
    
}

