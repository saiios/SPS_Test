//
//  CocktailRow.swift
//  CocktailBook
//
//  Created by APPLE on 12/12/24.
//

import SwiftUI

struct CocktailRow: View {
    let cocktail: Cocktail
    let isFavorite: Bool

    var body: some View {
        HStack {
            // Image Thumbnail
            Image(cocktail.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .cornerRadius(8)

            VStack(alignment: .leading) {
                Text(cocktail.name)
                    .font(.headline)
                    .foregroundColor(isFavorite ? .purple : .primary)
                Text(cocktail.shortDescription)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            if isFavorite {
                Image(systemName: "heart.fill")
                    .foregroundColor(.purple)
            }
        }
        .padding(.vertical, 8)
    }
}
