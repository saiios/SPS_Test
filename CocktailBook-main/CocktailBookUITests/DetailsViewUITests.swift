//
//  DetailsViewUITests.swift
//  CocktailBookUITests
//
//  Created by APPLE on 12/12/24.
//
import XCTest

class DetailsViewUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()

        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
        
        let cocktailBookListButton = app.buttons["Cocktail Book List"]
        
        TestHelper.tapButtonWithRetry(cocktailBookListButton, retries: 3, timeout: 15)
        
        let firstCocktailCell = app.collectionViews.cells.element(boundBy: 0)

        XCTAssertTrue(firstCocktailCell.waitForExistence(timeout: 5))
        firstCocktailCell.tap()
    }

    override func tearDown() {
        super.tearDown()
        app.terminate()
    }

    // Test if the Details view loads and displays the cocktail's name
    func testDetailsViewDisplaysCocktailName() {
        let cocktailNameLabel = app.staticTexts["CocktailName"]
        XCTAssertTrue(cocktailNameLabel.exists, "The cocktail name should be displayed.")

        print("Details view displays the cocktail's name correctly.")
    }

    // Test if preparation time information is displayed
    func testDetailsViewDisplaysPreparationTime() {
        let preparationTimeLabel = app.staticTexts["PreparationTime"]
        XCTAssertTrue(preparationTimeLabel.exists, "Preparation time should be displayed.")

        print("Details view displays preparation time correctly.")
    }

    // Test if the long description text is present
    func testDetailsViewDisplaysLongDescription() {
        let descriptionLabel = app.staticTexts["CocktailDescription"]
        XCTAssertTrue(descriptionLabel.exists, "Long description text should be displayed.")

        print("Details view shows the long description text.")
    }

    // Test if the Ingredients section is displayed
    func testDetailsViewDisplaysIngredients() {
        let ingredientsHeader = app.staticTexts["IngredientsHeader"]
        XCTAssertTrue(ingredientsHeader.exists, "The Ingredients section should be present.")

        print("Details view correctly displays the ingredients section.")
    }
}
