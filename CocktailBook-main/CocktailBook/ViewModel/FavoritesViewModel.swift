//
//  FavoritesViewModel.swift
//  CocktailBook
//
//  Created by APPLE on 12/12/24.
//

import SwiftUI
import Combine

class FavoritesViewModel: ObservableObject {
    @Published var favoriteCocktails: Set<String> = [] {
        didSet {
            saveFavorites()
        }
    }

    private var cancellables: Set<AnyCancellable> = []
    private let favoritesKey = "FavoriteCocktails"

    init() {
        loadFavorites()
    }

    // Check if a cocktail is a favorite
    func isFavorite(cocktailID: String) -> Bool {
        favoriteCocktails.contains(cocktailID)
    }

    // Toggle a cocktail's favorite status
    func toggleFavorite(cocktailID: String) {
        if favoriteCocktails.contains(cocktailID) {
            favoriteCocktails.remove(cocktailID)
        } else {
            favoriteCocktails.insert(cocktailID)
        }
    }

    // Save favorites to UserDefaults
    private func saveFavorites() {
        let favoritesArray = Array(favoriteCocktails)
        UserDefaults.standard.set(favoritesArray, forKey: favoritesKey)
    }

    // Load favorites from UserDefaults
    private func loadFavorites() {
        if let favoritesArray = UserDefaults.standard.array(forKey: favoritesKey) as? [String] {
            favoriteCocktails = Set(favoritesArray)
        }
    }
}
