//
//  EmptyStateView.swift
//  Movie App
//
//  Created by Leetha.dm on 18/04/26.
//

import SwiftUI

struct EmptyStateView: View {
    var message : String
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: AppConstants.emptyFallbackImage)
                .font(.largeTitle)
            
            Text(message)
                .foregroundColor(.gray)
        }
        .padding(.top, 50)
    }
    
}

