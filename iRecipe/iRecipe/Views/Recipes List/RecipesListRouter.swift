//
//  RecipesListRouter.swift
//  iRecipe
//
//  Created by Ricardo Casanova on 08/02/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import UIKit

class RecipesListRouter {
    
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController
    }
    
    public static func setupModule() -> UINavigationController {
        let recipesVC = RecipesListViewController()
        let recipesNVC = UINavigationController(rootViewController: recipesVC)
        recipesVC.presenter = RecipesListPresenter(view: recipesVC, navigationController: recipesNVC)
        return recipesNVC
    }
    
}

extension RecipesListRouter: RecipesListRouterDelegate {
    
    func showRecipeDetailWithUrl(_ url: URL) {
        let recipeDetailVC = RecipeDetailRouter.setupModuleWithRecipeUrl(url)
        navigationController?.pushViewController(recipeDetailVC, animated: true)
    }
    
}
