//
//  DetailsViewModelTests.swift
//  CocktailBookTests
//
//  Created by APPLE on 12/12/24.
//

import XCTest
@testable import CocktailBook

class DetailsViewModelTests: XCTestCase {

    func testDetailsViewModelToggleFavoriteCallback() {
        let cocktail = Cocktail(id: "4", name: "Cosmopolitan", type: "alcoholic", shortDescription: "Classic Cosmopolitan", longDescription: "Classic cocktail description", preparationMinutes: 5, imageName: "cosmopolitan", ingredients: ["Vodka", "Triple Sec"])
        var isFavoriteState = false

        let detailsViewModel = DetailsViewModel(cocktail: cocktail, isFavorite: isFavoriteState)

        detailsViewModel.toggleFavorite { newState in
            isFavoriteState = newState
        }

        XCTAssertTrue(isFavoriteState, "Cocktail should now be marked as a favorite.")

        detailsViewModel.toggleFavorite { newState in
            isFavoriteState = newState
        }

        XCTAssertFalse(isFavoriteState, "Cocktail should now be unmarked as a favorite.")
    }
}
