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
    
    public func save(title: String, href: URL?, ingredients: String, thumbnail: URL?) {
        if favoriteRecipeExists(title) { return }
        
        let favoriteRecipe = FavoriteRecipe()
        favoriteRecipe.recipeId = UUID().uuidString
        favoriteRecipe.title = title
        favoriteRecipe.href = href?.absoluteString
        favoriteRecipe.ingredients = ingredients
        favoriteRecipe.thumbnail = thumbnail?.absoluteString
        
        // Get the default Realm
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(favoriteRecipe)
        }
    }
    
    public func getAll() -> [FavoriteRecipe] {
        let realm = try! Realm()
        
        // Query Realm for all recipes
        // Order criteria -> time stamp
        // Order -> descending
        let favoriteRecipes = realm.objects(FavoriteRecipe.self).sorted(byKeyPath: "timestamp", ascending: false)
        return Array(favoriteRecipes)
    }
    
    public func deleteAll() {
        let realm = try! Realm()
        let favoriteRecipes = realm.objects(FavoriteRecipe.self)
        
        try! realm.write {
            realm.delete(favoriteRecipes)
        }
    }
    
    public func deleteRecipe(_ title: String) {
        let realm = try! Realm()
        let recipes = realm.objects(FavoriteRecipe.self).filter("title == %@", title)
        
        try! realm.write {
            realm.delete(recipes)
        }
    }
    
    public func favoriteRecipeExists(_ title: String) -> Bool {
        let realm = try! Realm()
        let favoriteRecipes = realm.objects(FavoriteRecipe.self).filter("title == %@", title)
        return favoriteRecipes.count == 1
    }
    
}
