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
}

// Presenter / Interactor
protocol FavoriteRecipesInteractorDelegate : class {
    func getFavoriteRecipes() -> [RecipeViewModel]
}

// Presenter / Router
protocol FavoriteRecipesRouterDelegate : class {
}

