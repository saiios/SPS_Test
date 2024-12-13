//
//  ListViewModelTests.swift
//  CocktailBookTests
//
//  Created by APPLE on 12/12/24.
//
import XCTest
@testable import CocktailBook

class ListViewModelTests: XCTestCase {

    var viewModel: ListViewModel!

    override func setUp() {
        super.setUp()
        viewModel = ListViewModel(api: FakeCocktailsAPI())  // Inject mock API
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    // Test if cocktails are fetched and loaded into the view model
    func testFetchCocktails() {
        let expectation = self.expectation(description: "Fetching cocktails")

        viewModel.fetchCocktails()

        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            XCTAssertNotNil(self.viewModel.allCocktails, "Cocktails should be loaded")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10)
    }

    // Test filtering functionality with the 'All' filter
    func testFilterAll() {
        let cocktail1 = Cocktail(id: "1", name: "Mojito", type: "alcoholic", shortDescription: "Classic Mojito", longDescription: "Refreshing Mojito", preparationMinutes: 5, imageName: "mojito", ingredients: ["Rum", "Mint"])
        let cocktail2 = Cocktail(id: "2", name: "Virgin Mojito", type: "non-alcoholic", shortDescription: "Non-alcoholic Mojito", longDescription: "No alcohol Mojito", preparationMinutes: 5, imageName: "virgin_mojito", ingredients: ["Lime", "Mint"])

        viewModel.allCocktails = [cocktail1, cocktail2]
        viewModel.selectedFilter = .all

        XCTAssertEqual(viewModel.filteredCocktails.count, 2, "Both cocktails should be present with the 'All' filter.")
    }

    // Test toggling a cocktail as a favorite
    func testToggleFavorite() {
        let cocktail = Cocktail(
            id: "1",
            name: "Mojito",
            type: "alcoholic",
            shortDescription: "Classic Mojito",
            longDescription: "Refreshing Mojito",
            preparationMinutes: 5,
            imageName: "mojito",
            ingredients: ["Rum", "Mint"]
        )

        XCTAssertFalse(viewModel.favoriteCocktails.contains(cocktail.id), "Cocktail should not be a favorite initially.")

        viewModel.toggleFavorite(for: cocktail.id)

        XCTAssertTrue(viewModel.favoriteCocktails.contains(cocktail.id), "Cocktail should now be marked as a favorite.")

        viewModel.toggleFavorite(for: cocktail.id)

        XCTAssertFalse(viewModel.favoriteCocktails.contains(cocktail.id), "Cocktail should be removed from favorites.")
    }

    // Test selecting filters updates filtered cocktails correctly
    func testApplyFilterChangesFilteredCocktails() {
        let cocktail1 = Cocktail(id: "1", name: "Mojito", type: "alcoholic", shortDescription: "Classic Mojito", longDescription: "Refreshing Mojito", preparationMinutes: 5, imageName: "mojito", ingredients: ["Rum", "Mint"])
        let cocktail2 = Cocktail(id: "2", name: "Virgin Mojito", type: "non-alcoholic", shortDescription: "Mocktail", longDescription: "Non-alcoholic Mojito", preparationMinutes: 5, imageName: "virgin_mojito", ingredients: ["Mint"])

        viewModel.allCocktails = [cocktail1, cocktail2]

        viewModel.selectedFilter = .alcoholic

        XCTAssertEqual(viewModel.filteredCocktails.count, 1, "Only the alcoholic Mojito should appear in the filter.")
        XCTAssertEqual(viewModel.filteredCocktails.first?.name, "Mojito", "Correct cocktail should be present in the filtered results.")
    }
}
