//
//  RecipeDetailProtocols.swift
//  iRecipe
//
//  Created by Ricardo Casanova on 11/02/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import Foundation

//__ View / Presenter
protocol RecipeDetailViewInjection : class {
    func loadUrl(_ url: URL)
}

@objc protocol RecipeDetailPresenterDelegate : class {
    func viewDidLoad()
}
