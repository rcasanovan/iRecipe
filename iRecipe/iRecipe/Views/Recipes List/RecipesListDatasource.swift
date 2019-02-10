//
//  RecipesListDatasource.swift
//  iRecipe
//
//  Created by Ricardo Casanova on 08/02/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import UIKit

class RecipesListDatasource: NSObject {
    
    public var items: [RecipeViewModel]
    public var isPaginating = true
    public weak var delegate: BaseViewController?
    
    public override init() {
        self.items = []
        super.init()
    }
}

extension RecipesListDatasource: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeCollectionViewCell.identifier, for: indexPath) as? RecipeCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let viewModel = items[indexPath.row]
        cell.bindWithViewModel(viewModel, at: indexPath.row)
        cell.delegate = delegate as? RecipeCollectionViewCellDelegate
        return cell
    }
    
}
