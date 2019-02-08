//
//  RecipesListProtocols.swift
//  iRecipe
//
//  Created by Ricardo Casanova on 08/02/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import Foundation

// View / Presenter
protocol RecipesListViewInjection : class {
    func showProgress(_ show: Bool, status: String)
    func showProgress(_ show: Bool)
    func showMessageWith(title: String, message: String, actionTitle: String)
    func loadRecipes(_ viewModels: [RecipeViewModel])
}

protocol RecipesListPresenterDelegate : class {
    func viewDidLoad()
}

// Presenter / Interactor

typealias RecipesGetRecipesCompletionBlock = (_ viewModel: [RecipeViewModel]?, _ success: Bool, _ error: ResultError?) -> Void

protocol RecipesListInteractorDelegate : class {
    func getRecipeList(search: String?, completion: @escaping RecipesGetRecipesCompletionBlock)
    func clear()
}

// Presenter / Router
protocol RecipesListRouterDelegate : class {
}
