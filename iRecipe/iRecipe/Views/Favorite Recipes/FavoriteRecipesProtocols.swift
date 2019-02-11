//
//  FavoriteRecipesProtocols.swift
//  iRecipe
//
//  Created by Ricardo Casanova on 10/02/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import Foundation

// View / Presenter
protocol FavoriteRecipesViewInjection : class {
    func loadRecipes(_ viewModels: [RecipeViewModel])
}

protocol FavoriteRecipesPresenterDelegate : class {
    func viewDidLoad()
    func refresh()
    func deleteRecipeAt(_ index: Int)
    func recipeSelectedAt(_ index: Int)
}

// Presenter / Interactor
protocol FavoriteRecipesInteractorDelegate : class {
    func getFavoriteRecipes() -> [RecipeViewModel]
    func deleteRecipeAt(_ index: Int)
    func getRecipeUrlSelectedAt(_ index: Int) -> URL?
}

// Presenter / Router
protocol FavoriteRecipesRouterDelegate : class {
    func showRecipeDetailWithUrl(_ url: URL)
}

