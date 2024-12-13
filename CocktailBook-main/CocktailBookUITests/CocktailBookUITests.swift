import XCTest

class CocktailBookUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()

        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
        
        let cocktailBookListButton = app.buttons["Cocktail Book List"]
        
        TestHelper.tapButtonWithRetry(cocktailBookListButton, retries: 3, timeout: 15)
    }

    override func tearDown() {
        super.tearDown()
        app.terminate()
    }
    
    // Test if the main view displays the list of cocktails
    func testCocktailListIsDisplayed() {
        let list = app.collectionViews["Cocktail Book List"]
                                
        XCTAssertTrue(list.waitForExistence(timeout: 15))
        print("Cocktail list is displayed.")
    }

    // Test filtering functionality using the picker
    func testFilterPicker() {
        let allSegmentPicker = app.buttons["All"]
        let alcoholicSegmentPicker = app.buttons["Alcoholic"]
        let nonAlcoholicSegmentPicker = app.buttons["Non-Alcoholic"]

        // Wait for the buttons to exist up to 5 seconds each
        let allExists = allSegmentPicker.waitForExistence(timeout: 5)
        let alcoholicExists = alcoholicSegmentPicker.waitForExistence(timeout: 5)
        let nonAlcoholicExists = nonAlcoholicSegmentPicker.waitForExistence(timeout: 5)

        // Verify that all three buttons exist
        XCTAssertTrue(allExists, "The segmented button 'All' should be present")
        XCTAssertTrue(alcoholicExists, "The segmented button 'Alcoholic' should be present")
        XCTAssertTrue(nonAlcoholicExists, "The segmented button 'Non Alcoholic' should be present")
    }
}
