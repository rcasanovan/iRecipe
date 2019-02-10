//
//  FavoriteRecipe.swift
//  iRecipe
//
//  Created by Ricardo Casanova on 10/02/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import Foundation
import RealmSwift

class FavoriteRecipe: Object {
    @objc dynamic var recipeId: String?
    @objc dynamic var title: String = ""
    @objc dynamic var href: String = ""
    @objc dynamic var ingredients: String = ""
    @objc dynamic var thumbnail: String = ""
    @objc dynamic var timestamp: TimeInterval = NSDate().timeIntervalSince1970
    
    override class func primaryKey() -> String? {
        return "recipeId"
    }
}
