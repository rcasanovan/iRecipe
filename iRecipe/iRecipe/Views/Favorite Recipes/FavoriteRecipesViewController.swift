//
//  FavoriteRecipesViewController.swift
//  iRecipe
//
//  Created by Ricardo Casanova on 10/02/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import Foundation

class FavoriteRecipesViewController: BaseViewController {
    
    public var presenter: FavoriteRecipesPresenterDelegate?
    
    private let customTitleView: CustomTitleView = CustomTitleView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        configureNavigationBar()
    }
    
}

// MARK: - Setup views
extension FavoriteRecipesViewController {
    
    /**
     * SetupViews
     */
    private func setupViews() {
        view.backgroundColor = .gray()
        edgesForExtendedLayout = []
        
        configureSubviews()
        addSubviews()
    }
    
    /**
     * ConfigureSubviews
     */
    private func configureSubviews() {
    }
    
    private func configureNavigationBar() {
        customTitleView.titleColor = .white()
        customTitleView.setTitle("Favorite recipes")
        customTitleView.subtitleColor = .white()
        customTitleView.setSubtitle("Recipe Puppy©")
        navigationItem.titleView = customTitleView
    }
    
    private func registerCells() {
    }
    
    private func setupDatasource() {
    }
    
}

// MARK: - Layout & constraints
extension FavoriteRecipesViewController {
    
    private struct Layout {
        
    }
    
    /**
     * Add subviews
     */
    private func addSubviews() {
    }
    
}

extension FavoriteRecipesViewController: FavoriteRecipesViewInjection {
    
}
