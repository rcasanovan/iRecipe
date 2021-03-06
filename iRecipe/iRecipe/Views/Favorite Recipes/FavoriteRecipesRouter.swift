//
//  FavoriteRecipesRouter.swift
//  iRecipe
//
//  Created by Ricardo Casanova on 10/02/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import Foundation

class FavoriteRecipesRouter {
    
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController
    }
    
    public static func setupModule() -> UINavigationController {
        let favoriteRecipesVC = FavoriteRecipesViewController()
        let favoriteRecipesNVC = UINavigationController(rootViewController: favoriteRecipesVC)
        favoriteRecipesVC.presenter = FavoriteRecipesPresenter(view: favoriteRecipesVC, navigationController: favoriteRecipesNVC)
        return favoriteRecipesNVC
    }
    
}

extension FavoriteRecipesRouter: FavoriteRecipesRouterDelegate {
    
    func showRecipeDetailWithUrl(_ url: URL) {
        let recipeDetailVC = RecipeDetailRouter.setupModuleWithRecipeUrl(url)
        navigationController?.pushViewController(recipeDetailVC, animated: true)
    }
    
}
