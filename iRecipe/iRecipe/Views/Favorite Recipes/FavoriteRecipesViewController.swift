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
    private let noFavoriteRecipesLabel: UILabel = UILabel()
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
        noFavoriteRecipesLabel.font = UIFont.mediumWithSize(size: 14.0)
        noFavoriteRecipesLabel.textColor = .white()
        noFavoriteRecipesLabel.text = "No favorite recipes :("
        noFavoriteRecipesLabel.textAlignment = .center
        noFavoriteRecipesLabel.isHidden = true
        
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
        favoriteRecipesContainerView.addSubview(noFavoriteRecipesLabel)
        
        let noFavoriteRecipesLabelCenterX = NSLayoutConstraint(item: noFavoriteRecipesLabel, attribute: .centerX, relatedBy: .equal, toItem: favoriteRecipesContainerView, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        favoriteRecipesContainerView.addConstraint(noFavoriteRecipesLabelCenterX)
        let noFavoriteRecipesLabelCenterY = NSLayoutConstraint(item: noFavoriteRecipesLabel, attribute: .centerY, relatedBy: .equal, toItem: favoriteRecipesContainerView, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        favoriteRecipesContainerView.addConstraint(noFavoriteRecipesLabelCenterY)
        favoriteRecipesContainerView.addConstraintsWithFormat("H:|[v0]|", views: noFavoriteRecipesLabel)
        favoriteRecipesContainerView.addConstraintsWithFormat("V:[v0(17.0)]", views: noFavoriteRecipesLabel)
        
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
        
        favoriteRecipesTableView?.isHidden = viewModels.isEmpty
        noFavoriteRecipesLabel.isHidden = !viewModels.isEmpty
    }
    
}
