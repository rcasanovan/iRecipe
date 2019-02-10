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
}

protocol FavoriteRecipesPresenterDelegate : class {
}

// Presenter / Interactor
protocol FavoriteRecipesInteractorDelegate : class {
    func getFavoriteRecipes() -> [RecipeViewModel]
}

// Presenter / Router
protocol FavoriteRecipesRouterDelegate : class {
}

