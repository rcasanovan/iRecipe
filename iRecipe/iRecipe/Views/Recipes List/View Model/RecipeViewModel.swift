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
    let href: String
    let hasLactose: Bool
    
    init(title: String, ingredients: String, recipeUrl: URL?, href: String, hasLactose: Bool) {
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
        
        return RecipeViewModel(title: recipeResponse.title, ingredients: recipeResponse.ingredients, recipeUrl: recipeUrl, href: recipeResponse.href, hasLactose: hasLactose)
    }
    
}
