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
    private weak var splitViewController: UISplitViewController?
    
    init(navigationController: UINavigationController? = nil, splitViewController: UISplitViewController? = nil) {
        self.navigationController = navigationController
        self.splitViewController = splitViewController
    }
    
    public static func setupModule(splitViewController: UISplitViewController? = nil) -> UINavigationController {
        let recipesVC = RecipesListViewController()
        let recipesNVC = UINavigationController(rootViewController: recipesVC)
        recipesVC.presenter = RecipesListPresenter(view: recipesVC, navigationController: recipesNVC, splitViewController: splitViewController)
        return recipesNVC
    }
    
}

extension RecipesListRouter: RecipesListRouterDelegate {
    
    func showRecipeDetailWithUrl(_ url: URL) {
        let recipeDetailVC = RecipeDetailRouter.setupModuleWithRecipeUrl(url)
        
        guard let splitViewController = splitViewController else {
            
            navigationController?.pushViewController(recipeDetailVC, animated: true)
            return
        }
        
        splitViewController.showDetailViewController(recipeDetailVC, sender: nil)
        
    }
    
}
