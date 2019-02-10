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
    
    @IBOutlet private weak var recipeImageView: UIImageView!
    @IBOutlet private weak var recipeTitleLabel: UILabel!
    @IBOutlet private weak var recipeIngredientsLabel: UILabel!
    @IBOutlet private weak var hasLactoseLabel: UILabel!
    
    private var viewModel: RecipeViewModel?
    private var index: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        recipeImageView.image = nil
        recipeTitleLabel.text = ""
        recipeIngredientsLabel.text = ""
    }
    
    public func bindWithViewModel(_ viewModel: RecipeViewModel, at index: Int) {
        self.index = index
        self.viewModel = viewModel
        configureRecipe()
    }
    
}

// MARK: - Setup views
extension FavoriteRecipeTableViewCell {
    
    /**
     * SetupViews
     */
    private func setupViews() {
        backgroundColor = .clear
        selectionStyle = .none
        configureSubviews()
    }
    
    /**
     * ConfigureSubviews
     */
    private func configureSubviews() {
        recipeImageView.layer.cornerRadius = 10.0
        recipeImageView.layer.borderColor = UIColor.white().cgColor
        recipeImageView.layer.borderWidth = 2.0
        recipeImageView.clipsToBounds = true
        
        recipeTitleLabel.textColor = .white()
        recipeTitleLabel.font = UIFont.blackWithSize(size: 15.0)
        
        recipeIngredientsLabel.textColor = .white()
        recipeIngredientsLabel.font = UIFont.mediumWithSize(size: 14.0)
        
        hasLactoseLabel.text = "Has lactose"
        hasLactoseLabel.backgroundColor = .yellow
        hasLactoseLabel.font = UIFont.mediumWithSize(size: 14.0)
        hasLactoseLabel.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 4.0)
        hasLactoseLabel.clipsToBounds = true
    }
    
}

extension FavoriteRecipeTableViewCell {
    
    private func configureRecipe() {
        recipeTitleLabel.text = viewModel?.title
        recipeIngredientsLabel.text = viewModel?.ingredients
        recipeIngredientsLabel.numberOfLines = 0
        configureRecipeImageWithUrl(viewModel?.recipeUrl)
    }
    
    private func configureRecipeImageWithUrl(_ url: URL?) {
        guard let url = url else {
            return
        }
        recipeImageView.contentMode = .scaleAspectFill
        recipeImageView.clipsToBounds = true
        recipeImageView.hnk_setImage(from: url, placeholder: nil)
    }
    
}
