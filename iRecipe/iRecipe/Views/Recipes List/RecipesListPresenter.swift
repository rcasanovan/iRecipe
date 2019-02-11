//
//  RecipesListPresenter.swift
//  iRecipe
//
//  Created by Ricardo Casanova on 08/02/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import Foundation

class RecipesListPresenter {
    
    private weak var view: RecipesListViewInjection?
    private let interactor: RecipesListInteractorDelegate
    private let router: RecipesListRouterDelegate
    private var recipeSearch: String?
    
    // MARK - Lifecycle
    init(view: RecipesListViewInjection, navigationController: UINavigationController? = nil, splitViewController: UISplitViewController? = nil) {
        self.view = view
        self.interactor = RecipesListInteractor()
        self.router = RecipesListRouter(navigationController: navigationController, splitViewController: splitViewController)
    }
    
}

extension RecipesListPresenter {
    
    private func getRecipes(_ search: String? = nil, showProgress: Bool) {
        view?.showProgress(showProgress, status: "Loading recipes")
        
        interactor.getRecipeList(search: search) { [weak self] (recipes, success, error) in
            guard let `self` = self else { return }
            
            self.view?.showProgress(false)
            
            if let recipes = recipes {
                self.view?.loadRecipes(recipes, fromBeginning: showProgress)
                return
            }
            
            if let error = error {
                self.view?.showMessageWith(title: "Oops... 🧐", message: error.localizedDescription, actionTitle: "Accept")
                return
            }
            
            if !success {
                self.view?.showMessageWith(title: "Oops... 🧐", message: "Something wrong happened. Please try again", actionTitle: "Accept")
                return
            }
        }
    }
    
}

extension RecipesListPresenter: RecipesListPresenterDelegate {
    
    func viewDidLoad() {
        interactor.clear()
        getRecipes(showProgress: true)
    }
    
    func searchRecipe(_ recipe: String?) {
        recipeSearch = recipe
        interactor.clear()
        getRecipes(recipeSearch, showProgress: true)
    }
    
    func recipeSelectedAt(_ index: Int) {
        guard let recipeSelected = interactor.getRecipeSelectedAt(index), let url = recipeSelected.href else {
            return
        }
        
        router.showRecipeDetailWithUrl(url)
    }
    
    func makeFavoriteSelectedAt(_ index: Int) {
        guard let recipeSelected = interactor.getRecipeSelectedAt(index), let href = recipeSelected.href?.absoluteString, let thumbnail = recipeSelected.recipeUrl?.absoluteString  else {
            return
        }
        
        FavoriteRecipeManager.shared.save(title: recipeSelected.title, href: href, ingredients: recipeSelected.ingredients, thumbnail: thumbnail)
        
        NotificationCenter.default.post(name: .reloadFavoriteRecipes, object: nil)
        
        view?.showMessageWith(title: "🥘🥗🌮🥧", message: "This recipe has been saved as favorite", actionTitle: "Accept")
    }
    
    func loadMoreRecipes() {
        getRecipes(recipeSearch, showProgress: false)
    }
    
}
