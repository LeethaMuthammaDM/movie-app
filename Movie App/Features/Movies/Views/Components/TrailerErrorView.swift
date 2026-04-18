//
//  TrailerErrorView.swift
//  Movie App
//
//  Created by Leetha.dm on 18/04/26.
//

import SwiftUI

struct TrailerErrorView: View {
    var message: String?
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: AppConstants.noTrailerImage)
                .font(.largeTitle)
            
            Text(message ?? AppConstants.anErrorOccurred)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity,minHeight: 200, alignment: .center)
    }
}
