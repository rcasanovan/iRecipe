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
    
    /**
     * Configure the tab bar for the app
     */
    private func configureTabBar() {
        //__ If the tab bar is configured -> do nothing
        if tabBarConfigured { return }
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white(), NSAttributedString.Key.font: UIFont.mediumWithSize(size: 10.0) ?? UIFont.systemFont(ofSize: 10.0)], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white(), NSAttributedString.Key.font: UIFont.mediumWithSize(size: 10.0) ?? UIFont.systemFont(ofSize: 10.0)], for: .selected)
        
        //__ Configure the tab bar items
        let recipesTabBarItem = UITabBarItem(title: "Recipes", image: nil, tag: 0)
        let favoritesTabBarItem = UITabBarItem(title: "Favorites", image: nil, tag: 1)
        
        //__ Setup the view controllers for the tab bar
        configureViewControllers([recipesTabBarItem, favoritesTabBarItem])
        
        tabBarConfigured = true
        
        selectedIndex = 0
    }
    
    /**
     * Configure the view controller for the tab bar
     *
     * - parameters:
     *      -tabBarItems: the tab bar items for the tabbar component
     */
    private func configureViewControllers(_ tabBarItems: [UITabBarItem]) {
        //__ If the device is an iPad
        if UIDevice.current.userInterfaceIdiom == .pad {
            //__ Create a split view controller
            let splitViewController =  UISplitViewController()
            
            //__ Setup the module with the recipes list.
            //__ In this case we need to set the split view controller
            //__ with the module
            recipesNavigationViewController = RecipesListRouter.setupModule(splitViewController: splitViewController)
            
            //__ Apply a guard to validate if we can setup the module
            //__ This is because recipesNavigationViewController is defined
            //__ as optional in the class
            guard let recipesNavigationViewController = recipesNavigationViewController else {
                return
            }
            
            //__ Configure the split view controller with the recipes list view
            //__ (for the fist time we don't need to setup the detail view)
            splitViewController.viewControllers = [recipesNavigationViewController]
            splitViewController.tabBarItem = tabBarItems[0]
            //__ All the views are visible
            splitViewController.preferredDisplayMode = .allVisible
            //__ Define the column width for the primary view
            splitViewController.maximumPrimaryColumnWidth = UIScreen.main.bounds.width / 2.0
            splitViewController.minimumPrimaryColumnWidth = UIScreen.main.bounds.width / 2.0
            splitViewController.preferredPrimaryColumnWidthFraction = 0.5
            
            //__ Configure the favorite recipes list section
            favoritesNavigationViewController.tabBarItem = tabBarItems[1]
            //__ Set the view controllers for the tab bar
            viewControllers = [splitViewController, favoritesNavigationViewController]
            return
        }
        
        //__ -> Otherwise the device is an iPhone
        
        //__ Setup the module with the recipes list.
        //__ In this case we need to setup the module with the default valie
        recipesNavigationViewController = RecipesListRouter.setupModule()
        
        //__ Apply a guard to validate if we can setup the module
        //__ This is because recipesNavigationViewController is defined
        //__ as optional in the class
        guard let recipesNavigationViewController = recipesNavigationViewController else {
            return
        }
        
        //__ Configure the tab bar items
        recipesNavigationViewController.tabBarItem = tabBarItems[0]
        favoritesNavigationViewController.tabBarItem = tabBarItems[1]
        //__ Set the view controllers for the tab bar
        viewControllers = [recipesNavigationViewController, favoritesNavigationViewController]
    }
    
}

