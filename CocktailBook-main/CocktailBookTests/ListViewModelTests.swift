//
//  ListViewModelTests.swift
//  CocktailBookTests
//
//  Created by APPLE on 12/12/24.
//
import XCTest
@testable import CocktailBook
import Combine

class ListViewModelTests: XCTestCase {

    var viewModel: ListViewModel!
    var mockAPI: FakeCocktailsAPI!

    override func setUp() {
        super.setUp()
        mockAPI = FakeCocktailsAPI(withFailure: .never)  // Use a mock API that doesn't fail
        viewModel = ListViewModel(api: mockAPI)
    }

    override func tearDown() {
        viewModel = nil
        mockAPI = nil
        super.tearDown()
    }

    // Test if cocktails are fetched and loaded into the view model
    func testFetchCocktails() {
        let expectation = self.expectation(description: "Fetching cocktails")

        viewModel.fetchCocktails()

        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            XCTAssertNotNil(self.viewModel.allCocktails, "Cocktails should be loaded")
            XCTAssertGreaterThan(self.viewModel.allCocktails.count, 0, "Cocktails array should not be empty")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10)
    }

    // Test failure scenario when API is unavailable
    func testFetchCocktailsFailure() {
        mockAPI = FakeCocktailsAPI(withFailure: .count(1))  // Simulate a failure once
        viewModel = ListViewModel(api: mockAPI)

        let expectation = self.expectation(description: "Fetching cocktails failure")

        viewModel.fetchCocktails()

        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            XCTAssertTrue(self.viewModel.errorMessage?.contains("currently unavailable") ?? false, "Error message should indicate unavailability")
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

    // Test filtering functionality with the 'Alcoholic' filter
    func testFilterAlcoholic() {
        let cocktail1 = Cocktail(id: "1", name: "Mojito", type: "alcoholic", shortDescription: "Classic Mojito", longDescription: "Refreshing Mojito", preparationMinutes: 5, imageName: "mojito", ingredients: ["Rum", "Mint"])
        let cocktail2 = Cocktail(id: "2", name: "Virgin Mojito", type: "non-alcoholic", shortDescription: "Mocktail", longDescription: "Non-alcoholic Mojito", preparationMinutes: 5, imageName: "virgin_mojito", ingredients: ["Mint"])

        viewModel.allCocktails = [cocktail1, cocktail2]
        viewModel.selectedFilter = .alcoholic

        XCTAssertEqual(viewModel.filteredCocktails.count, 1, "Only the alcoholic Mojito should appear in the filter.")
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
