//
//  FavoriteRecipesInteractor.swift
//  iRecipe
//
//  Created by Ricardo Casanova on 10/02/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import Foundation

class FavoriteRecipesInteractor {
    
}

extension FavoriteRecipesInteractor: FavoriteRecipesInteractorDelegate {
    
    func getFavoriteRecipes() -> [RecipeViewModel] {
        let favoriteRecipes = FavoriteRecipeManager.shared.getAll()
        return RecipeViewModel.getFavoriteRecipesViewModelsWith(favoriteRecipes)
    }
    
}
