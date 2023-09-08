//
//  TrendingRecipeCell.swift
//  BestRecipes
//
//  Created by Dmitriy Eliseev on 06.09.2023.
//

import UIKit
import Kingfisher

final class TrendingRecipeCell: UICollectionViewCell {
    //MARK: - Private properties
    private let recipeImageView: UIImageView = makeImageView()
    private let recipeTitle: UILabel = .makeLabel(
        font: .titleFont,
        color: .titleTextColor
    )
    private let creatorImage: UIImageView = makeImageView()
    private let burgerButton = makeButtonBurger()
    private let creatorLabel: UILabel = .makeLabel(
        font: .subtitleFont,
        color: .subtitleColor
    )
    private let buttonBookmark = makeButtonBookmark()
    private let ratingButton = makeRatingButton()
   
    //MARK: - init(_:)
    override init(frame: CGRect) {
        super .init(frame: frame)
        backgroundColor = .white
        contentView.clipsToBounds = true
        contentView.addSubviews(
            recipeImageView,
            ratingButton,
            buttonBookmark,
            recipeTitle,
            burgerButton,
            creatorImage,
            creatorLabel
        )
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Life Cycle
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
        
        creatorImage.layer.cornerRadius = creatorImage.frame.height / 2
        buttonBookmark.layer.cornerRadius = buttonBookmark.frame.height / 2
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        creatorImage.image = nil
        recipeImageView.image = nil
        recipeTitle.text = nil
        creatorLabel.text = nil
    }
    
    //MARK: - Public methods
    func configure(with recipe: Recipe) {
        recipeImageView.kf.setImage(with: URL(string: recipe.image))
        recipeTitle.text = recipe.title
        creatorLabel.text = recipe.sourceName
    }
    
    func setupTest() {
        recipeImageView.image = UIImage(named: "test_img")
        creatorImage.image = UIImage(named: "creator")
        recipeTitle.text = "How to sharwama at home"
        creatorLabel.text = "By Zeelicious foods"
        ratingButton.setTitle("4.5", for: .normal)
    }
    
}

private extension TrendingRecipeCell {
    struct Drawing {
        static let ratingOffset: CGFloat = 10
        static let bookmarkOffset: CGFloat = 8
        static let spacing: CGFloat = 10
        static let buttonMultiplier: CGFloat = 0.15
        static let contentMultiplier: CGFloat = 0.1
        static let imageMultiplier: CGFloat = 0.65
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            recipeImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            recipeImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            recipeImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            recipeImageView.heightAnchor.constraint(
                equalTo: contentView.heightAnchor,
                multiplier: Drawing.imageMultiplier
            ),
            
            ratingButton.leftAnchor.constraint(
                equalTo: contentView.leftAnchor,
                constant: Drawing.ratingOffset
            ),
            ratingButton.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: Drawing.ratingOffset
            ),
            ratingButton.heightAnchor.constraint(
                equalTo: contentView.heightAnchor,
                multiplier: Drawing.buttonMultiplier
            ),
    
            buttonBookmark.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: Drawing.bookmarkOffset
            ),
            buttonBookmark.rightAnchor.constraint(
                equalTo: contentView.rightAnchor,
                constant: -Drawing.bookmarkOffset
            ),
            buttonBookmark.heightAnchor.constraint(
                equalTo: contentView.heightAnchor,
                multiplier: Drawing.buttonMultiplier
            ),
            buttonBookmark.widthAnchor.constraint(equalTo: buttonBookmark.heightAnchor),
            
            recipeTitle.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            recipeTitle.topAnchor.constraint(
                equalTo: recipeImageView.bottomAnchor,
                constant: Drawing.spacing
            ),
            recipeTitle.heightAnchor.constraint(
                equalTo: contentView.heightAnchor,
                multiplier: Drawing.contentMultiplier
            ),
            
            burgerButton.topAnchor.constraint(
                equalTo: recipeImageView.bottomAnchor,
                constant: Drawing.spacing
            ),
            burgerButton.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            burgerButton.heightAnchor.constraint(
                equalTo: contentView.heightAnchor,
                multiplier: Drawing.contentMultiplier
            ),
            
            creatorImage.topAnchor.constraint(
                equalTo: recipeTitle.bottomAnchor,
                constant: Drawing.spacing
            ),
            creatorImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            creatorImage.widthAnchor.constraint(equalTo: creatorImage.heightAnchor),
            creatorImage.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            
            creatorLabel.centerYAnchor.constraint(equalTo: creatorImage.centerYAnchor),
            creatorLabel.leftAnchor.constraint(
                equalTo: creatorImage.rightAnchor,
                constant: Drawing.spacing
            ),
            creatorLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
    }
    
    static func makeStack(
        axis: NSLayoutConstraint.Axis,
        spacing: CGFloat = 0,
        distribution: UIStackView.Distribution = .fill
    ) -> UIStackView {
        let stack = UIStackView()
        stack.axis = axis
        stack.alignment = .center
        stack.backgroundColor = .white
        stack.distribution = distribution
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = spacing
        stack.clipsToBounds = true
        return stack
    }
    
    static func makeImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
    
    static func makeButtonBurger() -> UIButton {
        let button = UIButton()
        button.setImage(.burgerButtonImage, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    static func makeButtonBookmark() -> UIButton {
        let button = UIButton()
        button.setImage(.bookmarkImage, for: .normal)
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    static func makeRatingButton() -> UIButton {
        var configuration = UIButton.Configuration.gray()
        configuration.image = .starImage
        configuration.imagePlacement = .leading
        configuration.baseBackgroundColor = .lightGray
        configuration.imagePadding = 5
        let button = UIButton(configuration: configuration)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
}
