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
    
    private let customTitleView: CustomTitleView = CustomTitleView()
    private let searchView: SearchView = SearchView()
    private let recipesListContainerView: UIView = UIView()
    private var recipesListCollectionView: UICollectionView?
    private var datasource: RecipesListDatasource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        configureNavigationBar()
        presenter?.viewDidLoad()
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
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.estimatedItemSize = CGSize(width: getPostCellSide(), height: 320.0)
        recipesListCollectionView = UICollectionView(frame: recipesListContainerView.bounds, collectionViewLayout: flowLayout)
        recipesListCollectionView?.backgroundColor = .clear
        recipesListCollectionView?.isUserInteractionEnabled = true
        recipesListCollectionView?.showsVerticalScrollIndicator = false
        recipesListCollectionView?.delegate = self
        registerCells()
        setupDatasource()
        
        searchView.delegate = self
    }
    
    private func configureNavigationBar() {
        customTitleView.titleColor = .white()
        customTitleView.setTitle("Recipes")
        customTitleView.subtitleColor = .white()
        customTitleView.setSubtitle("Recipe Puppy©")
        navigationItem.titleView = customTitleView
    }
    
    private func registerCells() {
        recipesListCollectionView?.register(UINib(nibName: RecipeCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: RecipeCollectionViewCell.identifier)
    }
    
    private func setupDatasource() {
        if let recipesListCollectionView = recipesListCollectionView {
            datasource = RecipesListDatasource()
            datasource?.delegate = self
            recipesListCollectionView.dataSource = datasource
        }
    }
    
    private func getPostCellSide() -> CGFloat {
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        let cellContainerWidth: CGFloat = screenWidth - Layout.CollectionViewCell.centerSpacing*(CGFloat(Layout.CollectionViewCell.numberOfCellsInARow-1)) - Layout.CollectionViewCell.edgeSpacingLeft*CGFloat(Layout.CollectionViewCell.numberOfCellsInARow)
        return cellContainerWidth / CGFloat(Layout.CollectionViewCell.numberOfCellsInARow)
    }
    
}

// MARK: - Layout & constraints
extension RecipesListViewController {
    
    private struct Layout {
        
        struct CollectionViewCell {
            static let centerSpacing: CGFloat = 0.0
            static let edgeSpacingTop: CGFloat = 24.0
            static let edgeSpacingLeft: CGFloat = 0.0
            static let edgeSpacingBottom: CGFloat = 24.0
            static let edgeSpacingRight: CGFloat = 0.0
            static let numberOfCellsInARow: Int = 1
        }
        
    }
    
    /**
     * Add subviews
     */
    private func addSubviews() {
        view.addSubview(searchView)
        view.addSubview(recipesListContainerView)
        
        view.addConstraintsWithFormat("H:|[v0]|", views: searchView)
        view.addConstraintsWithFormat("V:|[v0(\(searchView.height))]", views: searchView)
        
        
        view.addConstraintsWithFormat("H:|[v0]|", views: recipesListContainerView)
        view.addConstraintsWithFormat("V:[v0][v1]|", views: searchView, recipesListContainerView)
        
        if let recipesListCollectionView = recipesListCollectionView {
            recipesListContainerView.addSubview(recipesListCollectionView)
            recipesListContainerView.addConstraintsWithFormat("H:|[v0]|", views: recipesListCollectionView)
            recipesListContainerView.addConstraintsWithFormat("V:|[v0]|", views: recipesListCollectionView)
        }
    }
    
}

// MARK:- UICollectionViewDelegate (with UICollectionViewDelegateFlowLayout)
extension RecipesListViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: Layout.CollectionViewCell.edgeSpacingTop, left: Layout.CollectionViewCell.edgeSpacingLeft, bottom: Layout.CollectionViewCell.edgeSpacingBottom, right: Layout.CollectionViewCell.edgeSpacingRight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Layout.CollectionViewCell.centerSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Layout.CollectionViewCell.centerSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.recipeSelectedAt(indexPath.row)
    }
    
}

extension RecipesListViewController: SearchViewDelegate {
    
    func searchButtonPressedWithSearch(_ search: String?) {
        presenter?.searchRecipe(search)
    }
    
}

extension RecipesListViewController: RecipeCollectionViewCellDelegate {
    
    func makeFavoritePressedAt(_ index: Int) {
        presenter?.makeFavoriteSelectedAt(index)
    }
    
}

extension RecipesListViewController: RecipesListViewInjection {
    
    func showProgress(_ show: Bool, status: String) {
        showLoader(show, status: status)
    }
    
    func showProgress(_ show: Bool) {
        showLoader(show)
    }
    
    func showMessageWith(title: String, message: String, actionTitle: String) {
        showAlertWith(title: title, message: message, actionTitle: actionTitle)
    }
    
    func loadRecipes(_ viewModels: [RecipeViewModel]) {
        datasource?.items = viewModels
        recipesListCollectionView?.reloadData()
    }
    
}
