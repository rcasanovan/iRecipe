//
//  FavoriteRecipesInteractor.swift
//  iRecipe
//
//  Created by Ricardo Casanova on 10/02/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import Foundation

class FavoriteRecipesInteractor {
    
    private var favoriteRecipes: [FavoriteRecipe]
    
    convenience init() {
        self.init(favoriteRecipes: [FavoriteRecipe]())
    }
    
    init(favoriteRecipes: [FavoriteRecipe]) {
        self.favoriteRecipes = favoriteRecipes
    }
    
}

extension FavoriteRecipesInteractor: FavoriteRecipesInteractorDelegate {
    
    func getFavoriteRecipes() -> [RecipeViewModel] {
        self.favoriteRecipes = FavoriteRecipeManager.shared.getAll()
        return RecipeViewModel.getFavoriteRecipesViewModelsWith(favoriteRecipes)
    }
    
    func deleteRecipeAt(_ index: Int) {
        if !favoriteRecipes.indices.contains(index) { return }
        
        let recipeSelected = favoriteRecipes[index]
        FavoriteRecipeManager.shared.deleteRecipe(recipeSelected.title)
    }
    
}
