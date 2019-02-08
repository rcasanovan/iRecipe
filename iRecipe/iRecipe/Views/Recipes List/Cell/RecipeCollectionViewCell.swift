//
//  RecipeCollectionViewCell.swift
//  iRecipe
//
//  Created by Ricardo Casanova on 08/02/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import UIKit

class RecipeCollectionViewCell: UICollectionViewCell {

    /**
     * Identifier for reusable cells
     */
    static public var identifier : String {
        return String(describing: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .yellow
    }
    
    public func bindWithViewModel(_ viewModel: RecipeViewModel) {
    }

}
