//
//  RecipeTitleCell.swift
//  BestRecipes
//
//  Created by Илья Шаповалов on 17.09.2023.
//

import UIKit
import Kingfisher

final class RecipeTitleCell: UICollectionViewCell {
    //MARK: - Private properties
    private let recipeImage: UIImageView = makeImageView()
    private let likesLabel: UIButton = makeRatingButton()
    
    //MARK: - init(_:)
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubviews(
            recipeImage,
            likesLabel
        )
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life cycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setConstraints()
    }
    
    //MARK: - Public methods
    func configure(with recipe: Recipe) {
        recipeImage.kf.setImage(with: URL(string: recipe.image))
        likesLabel.setTitle(recipe.aggregateLikes?.toLikesString, for: .normal)
    }
}

private extension RecipeTitleCell {
    struct Drawing {
        static let offset: CGFloat = 10
    }
    
    //MARK: - Private methods
    static func makeImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
    
    static func makeRatingButton() -> UIButton {
        var configuration = UIButton.Configuration.plain()
        configuration.image = .heartImage
        configuration.imagePlacement = .leading
        configuration.baseBackgroundColor = .white
        configuration.imagePadding = 5
        configuration.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 12) //fix
        let button = UIButton(configuration: configuration)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            recipeImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Drawing.offset),
            recipeImage.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -Drawing.offset),
            recipeImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Drawing.offset),
            recipeImage.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.8),
            
            likesLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Drawing.offset),
            likesLabel.topAnchor.constraint(equalTo: recipeImage.bottomAnchor, constant: Drawing.offset),
            likesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Drawing.offset)
        ])
    }
}
