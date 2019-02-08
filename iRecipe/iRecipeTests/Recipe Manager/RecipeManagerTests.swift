//
//  RecipeManagerTests.swift
//  iRecipeTests
//
//  Created by Ricardo Casanova on 08/02/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import XCTest
@testable import iRecipe

class RecipeManagerTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testIngredientsContainsLactose() {
        let ingredients = "coriander, cumin, eggs, garlic, green onion, vegetable oil, onions, milk, red pepper, salt, turmeric, cheese"
        let containsLactose = RecipeManager.shared.containsLactoseWith(ingredients)
        XCTAssert(containsLactose == true, "Error with contains lactose logic")
    }
    
    func testIngredientsContainsMilkLactose() {
        let ingredients = "coriander, cumin, eggs, garlic, green onion, vegetable oil, onions, milk, red pepper, salt, turmeric"
        let containsLactose = RecipeManager.shared.containsLactoseWith(ingredients)
        XCTAssert(containsLactose == true, "Error with contains lactose logic")
    }
    
    func testIngredientsContainsCheeseLactose() {
        let ingredients = "coriander, cumin, eggs, garlic, green onion, vegetable oil, onions, cheese, red pepper, salt, turmeric"
        let containsLactose = RecipeManager.shared.containsLactoseWith(ingredients)
        XCTAssert(containsLactose == true, "Error with contains lactose logic")
    }
    
    func testUpperCasedIngredientsContainsLactose() {
        let ingredients = "MILK, chEeSe"
        let containsLactose = RecipeManager.shared.containsLactoseWith(ingredients)
        XCTAssert(containsLactose == true, "Error with contains lactose logic")
    }
    
    func testIngredientsDoesntContainsLactose() {
        let ingredients = "coriander, cumin, eggs, garlic, green onion, vegetable oil, onions, red pepper, salt, turmeric"
        let containsLactose = RecipeManager.shared.containsLactoseWith(ingredients)
        XCTAssert(containsLactose == false, "Error with contains lactose logic")
    }

}
