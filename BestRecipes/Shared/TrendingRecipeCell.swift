//
//  TrendingRecipeCell.swift
//  BestRecipes
//
//  Created by Dmitriy Eliseev on 06.09.2023.
//

import UIKit
import Kingfisher

final class TrendingRecipeCell: UICollectionViewCell {
    private struct Drawing {
        static let ratingOffset: CGFloat = 10
        static let bookmarkOffset: CGFloat = 8
    }
    
    //MARK: - Private properties
    private let stackTitle: UIStackView = makeStack(
        axis: .horizontal,
        distribution: .fillProportionally
    )
    private let recipeImageView: UIImageView = makeImageView()
    private let titleLabel: UILabel = .makeLabel(
        font: .titleFont,
        color: .titleTextColor
    )
    private let stackCreator = makeStack(
        axis: .horizontal,
        distribution: .fillProportionally
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
        contentView.addSubviews(
            recipeImageView,
            ratingButton,
            buttonBookmark,
            stackTitle,
            stackCreator
        )
        
        stackTitle.addArrangedSubviews(
            titleLabel,
            burgerButton
        )
        
        stackCreator.addArrangedSubviews(
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
        setupTest()
        setupConstraints()
        
        ratingButton.setTitle("4.5", for: .normal)
        
        creatorImage.layer.cornerRadius = creatorImage.frame.height / 2
        buttonBookmark.layer.cornerRadius = buttonBookmark.frame.height / 2
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        creatorImage.image = nil
        recipeImageView.image = nil
        titleLabel.text = nil
        creatorLabel.text = nil
    }
    
    //MARK: - Public methods
    func configure(with recipe: Recipe) {
        recipeImageView.kf.setImage(with: URL(string: recipe.image))
        titleLabel.text = recipe.title
        creatorLabel.text = recipe.sourceName
    }
    
    private func setupTest() {
        recipeImageView.image = UIImage(named: "test_img")
        creatorImage.image = UIImage(named: "creator")
        titleLabel.text = "How to sharwama at home"
        creatorLabel.text = "By Zeelicious foods"
    }
    
    //MARK: - private funcs
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            recipeImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            recipeImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            recipeImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            recipeImageView.heightAnchor.constraint(equalToConstant: 240),
            
            ratingButton.leftAnchor.constraint(
                equalTo: leftAnchor,
                constant: Drawing.ratingOffset
            ),
            ratingButton.topAnchor.constraint(
                equalTo: topAnchor,
                constant: Drawing.ratingOffset
            ),
            
            buttonBookmark.topAnchor.constraint(
                equalTo: contentView.topAnchor, 
                constant: Drawing.bookmarkOffset
            ),
            buttonBookmark.rightAnchor.constraint(
                equalTo: contentView.rightAnchor,
                constant: -Drawing.bookmarkOffset
            ),
            
            stackTitle.topAnchor.constraint(equalTo: recipeImageView.bottomAnchor),
            stackTitle.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            stackTitle.rightAnchor.constraint(equalTo: contentView.rightAnchor),
                  
            stackCreator.topAnchor.constraint(equalTo: stackTitle.bottomAnchor),
            stackCreator.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            stackCreator.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
}

private extension TrendingRecipeCell {
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
        return stack
    }
    
    static func makeImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
    
    static func makeButtonBurger() -> UIButton {
        var configuration = UIButton.Configuration.plain()
        configuration.image = .burgerButtonImage
        let button = UIButton(configuration: configuration)
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

import SwiftUI
@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, xrOS 1.0, *)
#Preview {
    TrendingRecipeCell()
}
