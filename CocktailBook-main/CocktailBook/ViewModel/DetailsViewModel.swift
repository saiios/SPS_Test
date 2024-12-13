//
//  DetailsViewModel.swift
//  CocktailBook
//
//  Created by APPLE on 12/12/24.
//

import SwiftUI
import Combine

class DetailsViewModel: ObservableObject {
    let cocktail: Cocktail
    @Published var isFavorite: Bool
    
    init(cocktail: Cocktail, isFavorite: Bool) {
        self.cocktail = cocktail
        self.isFavorite = isFavorite
    }
    
    func toggleFavorite(onFavoriteToggle: @escaping (Bool) -> Void) {
        isFavorite.toggle()
        onFavoriteToggle(isFavorite)
    }
}

