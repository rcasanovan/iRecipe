//
//  RecipeViewModel.swift
//  iRecipe
//
//  Created by Ricardo Casanova on 08/02/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import Foundation

struct RecipeViewModel {
    
    let title: String
    let ingredients: String
    let recipeUrl: URL?
    let href: URL?
    let hasLactose: Bool
    
    init(title: String, ingredients: String, recipeUrl: URL?, href: URL?, hasLactose: Bool) {
        self.title = title
        self.ingredients = ingredients
        self.recipeUrl = recipeUrl
        self.href = href
        self.hasLactose = hasLactose
    }
    
    public static func getViewModelsWith(_ recipesResponse: [RecipeResponse]) -> [RecipeViewModel] {
        return recipesResponse.map { getViewModelWith($0) }
    }
    
    private static func getViewModelWith(_ recipeResponse: RecipeResponse) -> RecipeViewModel {
        
        let hasLactose = RecipeManager.shared.containsLactoseWith(recipeResponse.ingredients)
        let recipeUrl = URL(string: recipeResponse.thumbnail)
        let href = URL(string: recipeResponse.href)
        
        return RecipeViewModel(title: recipeResponse.title, ingredients: recipeResponse.ingredients, recipeUrl: recipeUrl, href: href, hasLactose: hasLactose)
    }
    
    public static func getFavoriteRecipesViewModelsWith(_ recipes: [FavoriteRecipe]) -> [RecipeViewModel] {
        return recipes.map { getFavoriteRecipeViewModelWith($0) }
    }
    
    private static func getFavoriteRecipeViewModelWith(_ recipe: FavoriteRecipe) -> RecipeViewModel {
        
        let hasLactose = RecipeManager.shared.containsLactoseWith(recipe.ingredients)
        let recipeUrl = URL(string: recipe.thumbnail)
        let href = URL(string: recipe.href)
        
        return RecipeViewModel(title: recipe.title, ingredients: recipe.ingredients, recipeUrl: recipeUrl, href: href, hasLactose: hasLactose)
    }
    
}
