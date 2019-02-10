//
//  FavoriteRecipeTableViewCell.swift
//  iRecipe
//
//  Created by Ricardo Casanova on 10/02/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import UIKit

class FavoriteRecipeTableViewCell: UITableViewCell {

    static public var identifier: String {
        return String(describing: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func bindWithViewModel(_ viewModel: RecipeViewModel, at index: Int) {
    }
    
}
