//
//  RecipesListViewController.swift
//  iRecipe
//
//  Created by Ricardo Casanova on 08/02/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import Foundation

class RecipesListViewController: BaseViewController {
    
    public var presenter: RecipesListPresenterDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        configureNavigationBar()
    }
    
}

// MARK: - Setup views
extension RecipesListViewController {
    
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
    }
    
}

// MARK: - Layout & constraints
extension RecipesListViewController {
    
    /**
     * Add subviews
     */
    private func addSubviews() {
    }
    
}

extension RecipesListViewController: RecipesListViewInjection {
    
}
