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
    func showSuccessMessage(_ message: String)
    func showAlertWith(title: String, message: String)
    func loadUrl(_ url: String)
    func showLoader(_ show: Bool)
}

@objc protocol RecipeDetailPresenterDelegate : class {
    func viewDidLoad()
}
