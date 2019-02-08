//
//  RecipesListPresenter.swift
//  iRecipe
//
//  Created by Ricardo Casanova on 08/02/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import Foundation

class MyGoalsPresenter {
    
    private weak var view: RecipesListViewInjection?
    private let interactor: RecipesListInteractorDelegate
    
    // MARK - Lifecycle
    init(view: RecipesListViewInjection, navigationController: UINavigationController? = nil) {
        self.view = view
        self.interactor = RecipesListInteractor()
    }
    
}
