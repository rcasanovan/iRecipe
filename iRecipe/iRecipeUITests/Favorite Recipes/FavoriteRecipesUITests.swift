//
//  FavoriteRecipesUITests.swift
//  FavoriteRecipesUITests
//
//  Created by Ricardo Casanova on 13/02/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import XCTest

class FavoriteRecipesUITests: XCTestCase {

    override func setUp() {
        super.setUp()
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testSaveFavoriteRecipe() {
        FavoriteRecipeManager.shared.deleteAll()
        
        let app = XCUIApplication()
        app.collectionViews.children(matching: .cell).element(boundBy: 0).buttons["Make favorite"].tap()
        app.alerts["🥘🥗🌮🥧"].buttons["Accept"].tap()
        app.tabBars.buttons["Favorites"].tap()
        
        let table = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .table).element
        XCTAssert(table.cells.count == 1, "Error saving a favorite recipe")
    }

}
