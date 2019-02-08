//
//  Recipe.swift
//  iRecipe
//
//  Created by Ricardo Casanova on 08/02/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import Foundation

public struct RecipesResponse: Decodable {
    
    let results: [RecipeResponse]
    
}

public struct RecipeResponse: Decodable {
    
    let title: String
    let href: String
    let ingredients: String
    let thumbnail: String
    
}
