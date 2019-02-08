//
//  RecipesListRouter.swift
//  iRecipe
//
//  Created by Ricardo Casanova on 08/02/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import UIKit

class RecipesListRouter {
    
    public static func setupModule(navigationController: UINavigationController? = nil) -> RecipesListViewController {
        let recipesVC = RecipesListViewController()
        return recipesVC
    }
    
}
