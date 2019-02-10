//
//  RecipesListInteractor.swift
//  iRecipe
//
//  Created by Ricardo Casanova on 08/02/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import Foundation

typealias getRecipesCompletionBlock = (Result<RecipesResponse?>) -> Void

class RecipesListInteractor {
    
    private let requestManager: RequestManager
    private var recipesViewModel: [RecipeViewModel]
    private var page: UInt
    
    convenience init() {
        self.init(requestManager: RequestManager(), recipesViewModel: [RecipeViewModel](), page: 1)
    }
    
    init(requestManager: RequestManager, recipesViewModel: [RecipeViewModel], page: UInt) {
        self.requestManager = requestManager
        self.recipesViewModel = recipesViewModel
        self.page = page
    }
    
}

extension RecipesListInteractor {
    
    private func getRecipes(search: String? = nil, page: UInt, simulatedJSONFile: String? = nil, completion: @escaping getRecipesCompletionBlock) {
        var recipesRequest = RecipesRequest(search: search, page: page)
        
        recipesRequest.completion = completion
        recipesRequest.simulatedResponseJSONFile = simulatedJSONFile
        requestManager.send(request: recipesRequest)
    }
    
    private func updateRecipesWith(_ recipes: [RecipeResponse]) {
        let recipesViewModel = RecipeViewModel.getViewModelsWith(recipes)
        self.recipesViewModel.append(contentsOf: recipesViewModel)
    }

}

extension RecipesListInteractor: RecipesListInteractorDelegate {
    
    func getRecipeList(search: String?, completion: @escaping RecipesGetRecipesCompletionBlock) {
        getRecipes(search: search, page: page) { [weak self] (response) in
            guard let `self` = self else { return }
            
            switch response {
            case .success(let response):
                guard let response = response else {
                    completion(nil, false, nil)
                    return
                }
                
                self.updateRecipesWith(response.results)
                completion(self.recipesViewModel, true, nil)
            case .failure(let error):
                completion(nil, false, error)
            }
        }
        
    }
    
    func clear() {
        recipesViewModel = []
        page = 1
    }
    
    func getRecipeSelectedAt(_ index: Int) -> RecipeViewModel? {
        if !recipesViewModel.indices.contains(index) { return nil }
        return recipesViewModel[index]
    }
    
}
