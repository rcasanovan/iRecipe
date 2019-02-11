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
    private let favoriteRecipesContainerView: UIView = UIView()
    private var favoriteRecipesTableView: UITableView?
    private var datasource: FavoriteRecipesDatasource?
    private var refreshControl: UIRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        configureNavigationBar()
        presenter?.viewDidLoad()
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
        favoriteRecipesContainerView.backgroundColor = .clear
        favoriteRecipesTableView = UITableView(frame: favoriteRecipesContainerView.bounds, style: .plain)
        favoriteRecipesTableView?.tableFooterView = UIView()
        favoriteRecipesTableView?.separatorStyle = .none
        favoriteRecipesTableView?.rowHeight = UITableView.automaticDimension
        favoriteRecipesTableView?.invalidateIntrinsicContentSize()
        favoriteRecipesTableView?.backgroundColor = .clear
        favoriteRecipesTableView?.showsVerticalScrollIndicator = false
        favoriteRecipesTableView?.delegate = self
        
        refreshControl.addTarget(self, action: #selector(userDidPullToRefresh), for: .valueChanged)
        refreshControl.tintColor = .white()
        favoriteRecipesTableView?.addSubview(refreshControl)
        
        registerCells()
        setupDatasource()
    }
    
    private func configureNavigationBar() {
        customTitleView.titleColor = .white()
        customTitleView.setTitle("Favorite recipes")
        customTitleView.subtitleColor = .white()
        customTitleView.setSubtitle("Recipe Puppy©")
        navigationItem.titleView = customTitleView
    }
    
    private func registerCells() {
        favoriteRecipesTableView?.register(UINib(nibName: FavoriteRecipeTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: FavoriteRecipeTableViewCell.identifier)
    }
    
    private func setupDatasource() {
        if let favoriteRecipesTableView = favoriteRecipesTableView {
            datasource = FavoriteRecipesDatasource()
            datasource?.delegate = self
            favoriteRecipesTableView.dataSource = datasource
        }
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
        view.addSubview(favoriteRecipesContainerView)
        
        view.addConstraintsWithFormat("H:|[v0]|", views: favoriteRecipesContainerView)
        view.addConstraintsWithFormat("V:|[v0]|", views: favoriteRecipesContainerView)
        
        if let favoriteRecipesTableView = favoriteRecipesTableView {
            favoriteRecipesContainerView.addSubview(favoriteRecipesTableView)
            favoriteRecipesContainerView.addConstraintsWithFormat("H:|[v0]|", views: favoriteRecipesTableView)
            favoriteRecipesContainerView.addConstraintsWithFormat("V:|[v0]|", views: favoriteRecipesTableView)
        }
    }
    
}

extension FavoriteRecipesViewController {
    
    @objc private func userDidPullToRefresh() {
        presenter?.refresh()
    }
    
}

// MARK: - UITableViewDelegate
extension FavoriteRecipesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.recipeSelectedAt(indexPath.row)
    }
    
}

extension FavoriteRecipesViewController: FavoriteRecipesViewInjection {
    
    func loadRecipes(_ viewModels: [RecipeViewModel]) {
        refreshControl.endRefreshing()
        datasource?.favoriteRecipes = viewModels
        favoriteRecipesTableView?.reloadData()
    }
    
}
