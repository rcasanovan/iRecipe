//
//  RecipeDetailPresenter.swift
//  iRecipe
//
//  Created by Ricardo Casanova on 11/02/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import Foundation

class RecipeDetailPresenter {
    
    private weak var view: RecipeDetailViewInjection?
    private var recipeUrl: URL
    
    // MARK - Lifecycle
    init(view: RecipeDetailViewInjection, recipeUrl: URL, navigationController: UINavigationController? = nil) {
        self.view = view
        self.recipeUrl = recipeUrl
    }
    
}

extension RecipeDetailPresenter: RecipeDetailPresenterDelegate {
    
    func viewDidLoad() {
        view?.loadUrl(recipeUrl)
    }
    
}
