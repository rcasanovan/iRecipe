//
//  FavoriteRecipesTests.swift
//  iRecipeTests
//
//  Created by Ricardo Casanova on 10/02/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import XCTest
@testable import iRecipe

class FavoriteRecipesTests: XCTestCase {

    override func setUp() {
        super.setUp()
        FavoriteRecipeManager.shared.deleteAll()
    }

    override func tearDown() {
        super.tearDown()
        FavoriteRecipeManager.shared.deleteAll()
    }

    func testSaveFavoriteRecipes() {
        FavoriteRecipeManager.shared.deleteAll()
        
        FavoriteRecipeManager.shared.save(title: "Baked Omelet With Broccoli &amp; Tomato", href: URL(string:"http://www.recipezaar.com/Baked-Omelet-With-Broccoli-Tomato-325014"), ingredients: "milk, cottage cheese, broccoli, cheddar cheese, basil, onion powder, eggs, garlic powder, roma tomato, salt", thumbnail: URL(string:"http://img.recipepuppy.com/123889.jpg"))
        
        FavoriteRecipeManager.shared.save(title: "Mild Curry Omelet", href: URL(string:"http://allrecipes.com/Recipe/Mild-Curry-Omelet/Detail.aspx"), ingredients: "coriander, cumin, eggs, garlic, green onion, vegetable oil, onions, red pepper, salt, turmeric", thumbnail: URL(string:""))
        
        let favoriteRecipes = FavoriteRecipeManager.shared.getAll()
        XCTAssert(favoriteRecipes.count == 2)
    }
    
    func testDeleteAllFavoriteRecipes() {
        FavoriteRecipeManager.shared.save(title: "Baked Omelet With Broccoli &amp; Tomato", href: URL(string:"http://www.recipezaar.com/Baked-Omelet-With-Broccoli-Tomato-325014"), ingredients: "milk, cottage cheese, broccoli, cheddar cheese, basil, onion powder, eggs, garlic powder, roma tomato, salt", thumbnail: URL(string:"http://img.recipepuppy.com/123889.jpg"))
        
        FavoriteRecipeManager.shared.save(title: "Mild Curry Omelet", href: URL(string:"http://allrecipes.com/Recipe/Mild-Curry-Omelet/Detail.aspx"), ingredients: "coriander, cumin, eggs, garlic, green onion, vegetable oil, onions, red pepper, salt, turmeric", thumbnail: URL(string:""))
        
        FavoriteRecipeManager.shared.deleteAll()
        
        let favoriteRecipes = FavoriteRecipeManager.shared.getAll()
        XCTAssert(favoriteRecipes.count == 0)
    }
    
    func testDeleteFavoriteRecipe() {
        FavoriteRecipeManager.shared.save(title: "Baked Omelet With Broccoli &amp; Tomato", href: URL(string:"http://www.recipezaar.com/Baked-Omelet-With-Broccoli-Tomato-325014"), ingredients: "milk, cottage cheese, broccoli, cheddar cheese, basil, onion powder, eggs, garlic powder, roma tomato, salt", thumbnail: URL(string:"http://img.recipepuppy.com/123889.jpg"))
        
        FavoriteRecipeManager.shared.save(title: "Mild Curry Omelet", href: URL(string:"http://allrecipes.com/Recipe/Mild-Curry-Omelet/Detail.aspx"), ingredients: "coriander, cumin, eggs, garlic, green onion, vegetable oil, onions, red pepper, salt, turmeric", thumbnail: URL(string:""))
        
        FavoriteRecipeManager.shared.deleteRecipe("Baked Omelet With Broccoli &amp; Tomato")
        
        let favoriteRecipes = FavoriteRecipeManager.shared.getAll()
        XCTAssert(favoriteRecipes.count == 1)
    }
    
    func testFavoriteRecipesOrder() {
        FavoriteRecipeManager.shared.deleteAll()
        
        FavoriteRecipeManager.shared.save(title: "Baked Omelet With Broccoli &amp; Tomato", href: URL(string:"http://www.recipezaar.com/Baked-Omelet-With-Broccoli-Tomato-325014"), ingredients: "milk, cottage cheese, broccoli, cheddar cheese, basil, onion powder, eggs, garlic powder, roma tomato, salt", thumbnail: URL(string:"http://img.recipepuppy.com/123889.jpg"))
        
        FavoriteRecipeManager.shared.save(title: "Mild Curry Omelet", href: URL(string:"http://allrecipes.com/Recipe/Mild-Curry-Omelet/Detail.aspx"), ingredients: "coriander, cumin, eggs, garlic, green onion, vegetable oil, onions, red pepper, salt, turmeric", thumbnail: URL(string:""))
        
        let favoriteRecipes = FavoriteRecipeManager.shared.getAll()
        XCTAssert(favoriteRecipes[1].title == "Baked Omelet With Broccoli &amp; Tomato" &&
            favoriteRecipes[0].title == "Mild Curry Omelet")
    }
    
    func testFavoriteRecipeExists() {
        FavoriteRecipeManager.shared.deleteAll()
        
        FavoriteRecipeManager.shared.save(title: "Baked Omelet With Broccoli &amp; Tomato", href: URL(string:"http://www.recipezaar.com/Baked-Omelet-With-Broccoli-Tomato-325014"), ingredients: "milk, cottage cheese, broccoli, cheddar cheese, basil, onion powder, eggs, garlic powder, roma tomato, salt", thumbnail: URL(string:"http://img.recipepuppy.com/123889.jpg"))
        
        FavoriteRecipeManager.shared.save(title: "Mild Curry Omelet", href: URL(string:"http://allrecipes.com/Recipe/Mild-Curry-Omelet/Detail.aspx"), ingredients: "coriander, cumin, eggs, garlic, green onion, vegetable oil, onions, red pepper, salt, turmeric", thumbnail: URL(string:""))
        
        let favoriteRecipeExists = FavoriteRecipeManager.shared.favoriteRecipeExists("Baked Omelet With Broccoli &amp; Tomato")
        XCTAssert(favoriteRecipeExists == true, "The recipe doesn't exist in the data base")
    }

}
