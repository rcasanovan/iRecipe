//
//  MainTabBar.swift
//  iRecipe
//
//  Created by Ricardo Casanova on 08/02/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import UIKit

class MainTabBar: UITabBarController {
    
    private var tabBarConfigured: Bool = false
    
    private let recipesViewController: RecipesListViewController = RecipesListRouter.setupModule()
    private let favoritesViewController: UIViewController = UIViewController()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureTabBar()
    }
    
}

// MARK: - Private section
extension MainTabBar {
    
    private func configureTabBar() {
        if tabBarConfigured { return }
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white(), NSAttributedString.Key.font: UIFont.mediumWithSize(size: 10.0) ?? UIFont.systemFont(ofSize: 10.0)], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white(), NSAttributedString.Key.font: UIFont.mediumWithSize(size: 10.0) ?? UIFont.systemFont(ofSize: 10.0)], for: .selected)
        
        let recipesTabBarItem = UITabBarItem(title: "Recipes", image: nil, tag: 0)
        let favoritesTabBarItem = UITabBarItem(title: "Favorites", image: nil, tag: 1)
        
        let recipesNavigationViewController = UINavigationController(rootViewController: recipesViewController)
        recipesNavigationViewController.tabBarItem = recipesTabBarItem
        
        let favoritesNavigationViewController = UINavigationController(rootViewController: favoritesViewController)
        favoritesNavigationViewController.tabBarItem = favoritesTabBarItem
        
        viewControllers = [recipesNavigationViewController, favoritesNavigationViewController]
        
        tabBarConfigured = true
        
        selectedIndex = 0
    }
    
}

