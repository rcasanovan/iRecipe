//
//  FavoriteRecipesPresenter.swift
//  iRecipe
//
//  Created by Ricardo Casanova on 10/02/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import Foundation

class FavoriteRecipesPresenter {
    
    private weak var view: FavoriteRecipesViewInjection?
    private let interactor: FavoriteRecipesInteractorDelegate
    private let router: FavoriteRecipesRouterDelegate
    
    // MARK - Lifecycle
    init(view: FavoriteRecipesViewInjection, navigationController: UINavigationController? = nil) {
        self.view = view
        self.interactor = FavoriteRecipesInteractor()
        self.router = FavoriteRecipesRouter(navigationController: navigationController)
    }
    
}

extension FavoriteRecipesPresenter {
    
    private func getFavoriteRecipes() {
        let favoriteRecipes = interactor.getFavoriteRecipes()
        view?.loadRecipes(favoriteRecipes)
    }
    
}

extension FavoriteRecipesPresenter: FavoriteRecipesPresenterDelegate {
    
    func viewDidLoad() {
        getFavoriteRecipes()
    }
    
    func refresh() {
        getFavoriteRecipes()
    }
    
    func deleteRecipeAt(_ index: Int) {
        interactor.deleteRecipeAt(index)
        getFavoriteRecipes()
    }
    
    func recipeSelectedAt(_ index: Int) {
        guard let url = interactor.getRecipeUrlSelectedAt(index) else {
            return
        }
        
        router.showRecipeDetailWithUrl(url)
    }
    
}
