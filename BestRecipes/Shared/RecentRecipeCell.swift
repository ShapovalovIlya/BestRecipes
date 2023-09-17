//
//  RecentRecipeCell.swift
//  BestRecipes
//
//  Created by Dmitriy Eliseev on 06.09.2023.
//

import UIKit
import Kingfisher

final class RecentRecipeCell: UICollectionViewCell {
    //MARK: - Private properties
    private let recipeImage: UIImageView = makeImageView()
    private let recipeTitle: UILabel = .makeLabel(
        font: .titleFont,
        color: .titleTextColor,
        numberOfLines: 2
    )
    private let creatorTitle: UILabel = .makeLabel(
        font: .subtitleFont,
        color: .subtitleColor
    )
    
    //MARK: - init(_:)
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.clipsToBounds = true
        contentView.addSubviews(
            recipeImage,
            recipeTitle,
            creatorTitle
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life Cycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupConstraints()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        recipeImage.image = nil
        recipeTitle.text = nil
        creatorTitle.text = nil
    }
    
    //MARK: - Public methods
    func configure(with recipe: Recipe) {
        recipeImage.kf.setImage(with: URL(string: recipe.image))
        recipeTitle.text = recipe.title
        creatorTitle.text = recipe.sourceName
    }
    
    func setupTest() {
        recipeImage.image = UIImage(named: "foodPhoto")
        recipeTitle.text = "Kelewele Ghanian Recipe"
        creatorTitle.text = "By Zeelicious Foods"
    }
}

//MARK: - Private extensions
private extension RecentRecipeCell {
    private struct Drawing {
        static let imageHeight: CGFloat = 124
        static let spacing: CGFloat = 10
    }
    
    static func makeImageView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            // recipeImage
            recipeImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            recipeImage.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            recipeImage.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            recipeImage.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.65),
            // recipeTitle
            recipeTitle.topAnchor.constraint(equalTo: recipeImage.bottomAnchor,constant: Drawing.spacing),
            recipeTitle.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            recipeTitle.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            
            creatorTitle.topAnchor.constraint(equalTo: recipeTitle.bottomAnchor, constant: Drawing.spacing),
            creatorTitle.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            creatorTitle.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            creatorTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
