//
//  RecipeManager.swift
//  iRecipe
//
//  Created by Ricardo Casanova on 08/02/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import Foundation

class RecipeManager: NSObject {
    
    static let shared: RecipeManager = { return RecipeManager() }()
    
    public func containsLactoseWith(_ ingredients: String) -> Bool {
        let ingredientesLowerCased = ingredients.lowercased()
        return ingredientesLowerCased.contains("cheese") || ingredientesLowerCased.contains("milk")
    }

}
