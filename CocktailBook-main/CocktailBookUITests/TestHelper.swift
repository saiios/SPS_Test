//
//  TestHelper.swift
//  CocktailBook
//
//  Created by APPLE on 13/12/24.
//


import XCTest

class TestHelper {
    static func tapButtonWithRetry(_ button: XCUIElement, retries: Int, timeout: TimeInterval) {
        for _ in 0..<retries {
            XCTAssertTrue(button.waitForExistence(timeout: timeout), "Button did not appear within the timeout")
            button.tap()
        }
    }
}
