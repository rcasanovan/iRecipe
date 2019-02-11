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
    
    private var recipesNavigationViewController: UINavigationController?
    private var favoritesNavigationViewController: UINavigationController = FavoriteRecipesRouter.setupModule()
    
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
        
        configureViewControllers([recipesTabBarItem, favoritesTabBarItem])
        
        tabBarConfigured = true
        
        selectedIndex = 0
    }
    
    private func configureViewControllers(_ tabBarItems: [UITabBarItem]) {
        if UIDevice.current.userInterfaceIdiom == .pad {
            let splitViewController =  UISplitViewController()
            
            recipesNavigationViewController = RecipesListRouter.setupModule(splitViewController: splitViewController)
            
            guard let recipesNavigationViewController = recipesNavigationViewController else {
                return
            }
            
            splitViewController.viewControllers = [recipesNavigationViewController]
            splitViewController.tabBarItem = tabBarItems[0]
            splitViewController.preferredDisplayMode = .allVisible
            splitViewController.maximumPrimaryColumnWidth = UIScreen.main.bounds.width / 2.0
            splitViewController.minimumPrimaryColumnWidth = UIScreen.main.bounds.width / 2.0
            splitViewController.preferredPrimaryColumnWidthFraction = 0.5
            favoritesNavigationViewController.tabBarItem = tabBarItems[1]
            viewControllers = [splitViewController, favoritesNavigationViewController]
            return
        }
        
        recipesNavigationViewController = RecipesListRouter.setupModule()
        
        guard let recipesNavigationViewController = recipesNavigationViewController else {
            return
        }
        
        recipesNavigationViewController.tabBarItem = tabBarItems[0]
        favoritesNavigationViewController.tabBarItem = tabBarItems[1]
        viewControllers = [recipesNavigationViewController, favoritesNavigationViewController]
    }
    
}

