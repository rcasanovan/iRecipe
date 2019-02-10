//
//  RecipeCollectionViewCell.swift
//  iRecipe
//
//  Created by Ricardo Casanova on 08/02/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import UIKit

protocol RecipeCollectionViewCellDelegate {
    func makeFavoritePressedAt(_ index: Int)
}

class RecipeCollectionViewCell: UICollectionViewCell {
    
    public var delegate: RecipeCollectionViewCellDelegate?

    /**
     * Identifier for reusable cells
     */
    static public var identifier : String {
        return String(describing: self)
    }
    
    @IBOutlet private weak var recipeContainerView: UIView!
    @IBOutlet private weak var recipeImageView: UIImageView!
    @IBOutlet private weak var recipeTitleLabel: UILabel!
    @IBOutlet private weak var recipeIngredientsLabel: UILabel!
    @IBOutlet private weak var makeFavoriteButton: UIButton!
    
    lazy private var width: NSLayoutConstraint = {
        let width = contentView.widthAnchor.constraint(equalToConstant: bounds.size.width)
        width.isActive = true
        return width
    }()
    
    private var viewModel: RecipeViewModel?
    private var index: Int?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        recipeImageView.image = nil
        recipeTitleLabel.text = ""
        recipeIngredientsLabel.text = ""
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        width.constant = bounds.size.width
        return contentView.systemLayoutSizeFitting(CGSize(width: targetSize.width, height: 1))
    }
    
    public func bindWithViewModel(_ viewModel: RecipeViewModel, at index: Int) {
        self.index = index
        self.viewModel = viewModel
        configureRecipe()
    }

}

// MARK: - Setup views
extension RecipeCollectionViewCell {
    
    /**
     * SetupViews
     */
    private func setupViews() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        configureSubviews()
    }
    
    /**
     * ConfigureSubviews
     */
    private func configureSubviews() {
        recipeContainerView.backgroundColor = .gray()
        
        recipeTitleLabel.textColor = .white()
        recipeTitleLabel.font = UIFont.blackWithSize(size: 14.0)
        
        recipeIngredientsLabel.textColor = .white()
        recipeIngredientsLabel.font = UIFont.blackWithSize(size: 14.0)
        
        makeFavoriteButton.backgroundColor = .green()
        makeFavoriteButton.titleLabel?.font = UIFont.blackWithSize(size: 14.0)
        makeFavoriteButton.setTitleColor(.white(), for: .normal)
        makeFavoriteButton.layer.cornerRadius = makeFavoriteButton.frame.height / 2
        makeFavoriteButton.layer.borderColor = UIColor.white().cgColor
        makeFavoriteButton.layer.borderWidth = 2.0
        makeFavoriteButton.clipsToBounds = true
        makeFavoriteButton.setTitle("Make favorite", for: .normal)
        makeFavoriteButton.addTarget(self, action: #selector(makeFavoritePressed), for: .touchUpInside)
    }
    
}

extension RecipeCollectionViewCell {
    
    private func configureRecipe() {
        recipeTitleLabel.text = viewModel?.title
        recipeIngredientsLabel.text = viewModel?.ingredients
        recipeIngredientsLabel.numberOfLines = 0
        recipeIngredientsLabel.sizeToFit()
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

extension RecipeCollectionViewCell {
    
    @objc private func makeFavoritePressed() {
        guard let index = index else {
            return
        }
        delegate?.makeFavoritePressedAt(index)
    }
    
}
