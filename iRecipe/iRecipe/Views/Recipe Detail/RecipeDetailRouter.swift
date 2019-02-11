//
//  RecipeDetailRouter.swift
//  iRecipe
//
//  Created by Ricardo Casanova on 11/02/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import Foundation

class RecipeDetailRouter {
    
    public static func setupModuleWithRecipeUrl(_ recipeUrl: URL) -> RecipeDetailViewController {
        let recipeDetailVC = RecipeDetailViewController()
        recipeDetailVC.presenter = RecipeDetailPresenter(view: recipeDetailVC, recipeUrl: recipeUrl)
        return recipeDetailVC
    }
    
}
