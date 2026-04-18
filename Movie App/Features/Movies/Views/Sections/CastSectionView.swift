//
//  CastSectionView.swift
//  Movie App
//
//  Created by Leetha.dm on 18/04/26.
//

import SwiftUI

struct CastSectionView: View {
    let cast: [Cast]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(AppConstants.cast)
                .font(.headline)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(cast.prefix(10)) { actor in
                        VStack {
                            CachedAsyncImage(url: actor.profileURL, fallbackImage: AppConstants.castFallbackImage)
                                .frame(width: 60, height: 60)
                                .clipShape(Circle())
                            
                            Text(actor.name)
                                .font(.caption)
                                .lineLimit(1)
                        }
                    }
                }
            }
        }
    }
    
}

