//
//  ListViewModel.swift
//  CocktailBook
//
//  Created by APPLE on 12/12/24.
//
import SwiftUI
import Combine

class ListViewModel: ObservableObject {
    @Published var allCocktails: [Cocktail] = []
    @Published var filteredCocktails: [Cocktail] = []
    @Published var favoriteCocktails: Set<String> = [] {
        didSet {
            saveFavorites()
        }
    }
    @Published var isLoading: Bool = true
    @Published var errorMessage: String? = nil
    @Published var selectedFilter: CocktailFilter = .all {
        didSet {
            applyFilter()
        }
    }

    private let api: CocktailsAPI
    private let favoritesKey = "FavoriteCocktails"

    init(api: CocktailsAPI = FakeCocktailsAPI(withFailure: .count(3))) {
        self.api = api
        loadFavorites()
        fetchCocktails()
    }

    // Fetch cocktails from API
    func fetchCocktails() {
        isLoading = true
        errorMessage = nil
        api.fetchCocktails { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let data):
                    do {
                        self.allCocktails = try JSONDecoder().decode([Cocktail].self, from: data)
                        self.applyFilter()
                    } catch {
                        self.errorMessage = "Failed to decode cocktails."
                    }
                case .failure(let error):
                    if let apiError = error as? CocktailsAPIError, apiError == .unavailable {
                        self.errorMessage = "The cocktail service is currently unavailable. Please try again."
                    }
                }
            }
        }
    }

    // Apply selected filter and sort favorites to the top
    func applyFilter() {
        var cocktailsToDisplay: [Cocktail]

        switch selectedFilter {
        case .all:
            cocktailsToDisplay = allCocktails
        case .alcoholic:
            cocktailsToDisplay = allCocktails.filter { $0.type == "alcoholic" }
        case .nonAlcoholic:
            cocktailsToDisplay = allCocktails.filter { $0.type == "non-alcoholic" }
        }

        filteredCocktails = cocktailsToDisplay.sorted {
            if favoriteCocktails.contains($0.id) != favoriteCocktails.contains($1.id) {
                return favoriteCocktails.contains($0.id)
            }
            return $0.name < $1.name
        }
    }

    // Toggle favorite state for a cocktail
    func toggleFavorite(for cocktailID: String) {
        if favoriteCocktails.contains(cocktailID) {
            favoriteCocktails.remove(cocktailID)
        } else {
            favoriteCocktails.insert(cocktailID)
        }
        applyFilter()
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

    // Retry fetching cocktails
    func retryFetch() {
        fetchCocktails()
    }
}
