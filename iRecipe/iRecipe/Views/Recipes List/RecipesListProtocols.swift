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
}

protocol RecipesListPresenterDelegate : class {
}

// Presenter / Interactor

typealias RecipesGetRecipesCompletionBlock = (_ viewModel: [RecipeViewModel]?, _ success: Bool, _ error: ResultError?) -> Void

protocol RecipesListInteractorDelegate : class {
    func getRecipeList(search: String? = nil, completion: @escaping RecipesGetRecipesCompletionBlock)
}

// Presenter / Router
protocol RecipesListRouterDelegate : class {
}
