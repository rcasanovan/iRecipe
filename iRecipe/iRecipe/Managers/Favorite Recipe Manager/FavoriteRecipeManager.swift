//
//  FavoriteRecipeManager.swift
//  iRecipe
//
//  Created by Ricardo Casanova on 10/02/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import Foundation
import RealmSwift

class FavoriteRecipeManager: NSObject {
    
    static let shared: FavoriteRecipeManager = { return FavoriteRecipeManager() }()
    
    public func save(id: String, title: String, href: String, ingredients: String, thumbnail: String) {
        if favoriteRecipeExists(id) { return }
        
        let favoriteRecipe = FavoriteRecipe()
        favoriteRecipe.recipeId = id
        favoriteRecipe.title = title
        favoriteRecipe.href = href
        favoriteRecipe.ingredients = ingredients
        favoriteRecipe.thumbnail = thumbnail
        
        // Get the default Realm
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(favoriteRecipe)
        }
    }
    
    public func favoriteRecipeExists(_ id: String) -> Bool {
        let realm = try! Realm()
        let favoriteRecipes = realm.objects(FavoriteRecipe.self).filter("recipeId == %@", id)
        return favoriteRecipes.count == 1
    }
    
}
