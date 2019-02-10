//
//  FavoriteRecipesDatasource.swift
//  iRecipe
//
//  Created by Ricardo Casanova on 10/02/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import UIKit

class FavoriteRecipesDatasource: NSObject {
    
    public var favoriteRecipes: [RecipeViewModel]
    
    public override init() {
        favoriteRecipes = []
        super.init()
    }
    
}

extension FavoriteRecipesDatasource {
    
    private func generateFavoriteRecipeCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteRecipeTableViewCell.identifier, for: indexPath) as? FavoriteRecipeTableViewCell else {
            return UITableViewCell()
        }
        
        //__ Bind the cell
        let viewModel = favoriteRecipes[indexPath.row]
        cell.bindWithViewModel(viewModel, at: indexPath.row)
        
        return cell
    }
    
}

// MARK: - UITableViewDataSource
extension FavoriteRecipesDatasource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteRecipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return generateFavoriteRecipeCell(tableView, cellForRowAt: indexPath)
    }
    
}
