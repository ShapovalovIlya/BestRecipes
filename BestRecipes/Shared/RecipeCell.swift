//
//  RecipeCell.swift
//  BestRecipes
//
//  Created by Илья Шаповалов on 08.09.2023.
//

import UIKit
import Kingfisher

final class RecipeCell: UICollectionViewCell {
    //MARK: - Private properties
    private let recipeImage: UIImageView = makeImageView()
    private let ratingButton: UIButton = makeRatingButton()
    private let recipeTitle: UILabel = .makeLabel(
        font: .titleFont,
        color: .white,
        numberOfLines: 2
    )
    private let recipeDescription: UILabel = .makeLabel(
        font: .subtitleFont,
        color: .white
    )
    
    //MARK: - init(_:)
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.clipsToBounds = true
        contentView.addSubviews(
            recipeImage,
            ratingButton,
            recipeTitle,
            recipeDescription
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
        recipeTitle.text = recipe.title
        recipeDescription.text = combineSubtitle(for: recipe)
        ratingButton.setTitle(
            recipe.aggregateLikes?.toLikesString,
            for: .normal
        )
    }
    
    func testConfigure() {
        recipeImage.image = UIImage(named: "test_img")
        ratingButton.setTitle(3000.toLikesString, for: .normal)
        recipeTitle.text = "How to make yam & vegetable sauce at home"
        recipeDescription.text = "9 Ingredients | 25 min"
    }
    
    func setCountLikes(count: Float)->String{
        switch count {
        case 0...99:
            return "\(String(format: "%.0f", count))"
        case 100...9999:
            return "\(String(format: "%.1f", count/1000))K"
        case 10000... :
            return ">10K"
        default:
           return "0"
        }
    }
}

private extension RecipeCell {
    private struct Drawing {
        static let ratingOffset: CGFloat = 8
        static let contentOffset: CGFloat = 15
        static let spacing: CGFloat = 10
    }
    
    //MARK: - Private methods
    func combineSubtitle(for recipe: Recipe) -> String {
        [
            recipe.extendedIngredients?.count.description ?? "0",
            "ingredients",
            "|",
            recipe.readyInMinutes?.description ?? "0",
            "min"
        ].joined(separator: " ")
    }
    
    static func makeImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
    
    static func makeRatingButton() -> UIButton {
        var configuration = UIButton.Configuration.gray()
        configuration.image = .heartImage
        configuration.imagePlacement = .leading
        configuration.baseBackgroundColor = .lightGray
        configuration.imagePadding = 5
        configuration.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 12) //fix
        let button = UIButton(configuration: configuration)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            recipeImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            recipeImage.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            recipeImage.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            recipeImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            ratingButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Drawing.ratingOffset),
            ratingButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Drawing.ratingOffset),
            
            recipeDescription.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Drawing.contentOffset),
            recipeDescription.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Drawing.spacing),
            recipeDescription.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -Drawing.contentOffset),
            recipeDescription.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.1),
            
            recipeTitle.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Drawing.contentOffset),
            recipeTitle.bottomAnchor.constraint(equalTo: recipeDescription.topAnchor, constant: -Drawing.spacing),
            recipeTitle.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -Drawing.contentOffset),
        ])
    }
}
