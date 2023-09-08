//
//  RecipeCategoryCell.swift
//  BestRecipes
//
//  Created by Dmitriy Eliseev on 06.09.2023.
//

import UIKit

final class RecipeCategoryCell: UICollectionViewCell {
    private struct Drawing {
        static let imageOffset: CGFloat = 22
        static let contentOffset: CGFloat = 12
        static let spacing: CGFloat = 10
    }
    
    //MARK: - Private properties
    private let categoryImage: UIImageView = makeImageView()
    private let recipeTitle: UILabel = .makeLabel(
        font: .titleFont,
        color: .titleTextColor,
        numberOfLines: 2
    )
    private let timeLabel: UILabel = .makeLabel(
        font: .subtitleFont,
        color: .subtitleColor
    )
    private let timeTextLabel: UILabel = .makeLabel(
        font: .titleFont,
        color: .titleTextColor
    )
    private let bookmarkButton: UIButton = makeButtonBookmark()
    private let bottomContainer: UIStackView = makeBottomStack()
    
    //MARK: - init(_:)
    override init(frame: CGRect) {
        super .init(frame: frame)
        contentView.clipsToBounds = true
        timeLabel.text = "Time"
        bottomContainer.addArrangedSubviews(
            timeTextLabel,
            bookmarkButton
        )
        
        contentView.addSubviews(
            categoryImage,
            recipeTitle,
            timeLabel,
            bottomContainer
        )
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life Cycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        categoryImage.layer.cornerRadius = categoryImage.frame.height * 0.5
        setupConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        categoryImage.image = nil
        recipeTitle.text = nil
        timeTextLabel.text = nil
    }
    
    //MARK: - Public methods
    func configure(with recipe: Recipe) {
        
    }
    
    func setupTest() {
        categoryImage.image = UIImage(named: "foodPhoto")
        recipeTitle.text = "Chicken and Vegetable wrap"
        timeTextLabel.text = "5 Mins"
    }
}

//MARK: - Private methods
private extension RecipeCategoryCell {
    
    static func makeImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
    
    static func makeButtonBookmark() -> UIButton {
        let button = UIButton()
        button.setImage(.bookmarkImage, for: .normal)
        button.tintColor = .lightGray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    static func makeBottomStack() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }
   
    func setupConstraints() {
        NSLayoutConstraint.activate([
            categoryImage.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 2
            ),
            categoryImage.leftAnchor.constraint(
                equalTo: contentView.leftAnchor,
                constant: Drawing.imageOffset
            ),
            categoryImage.rightAnchor.constraint(
                equalTo: contentView.rightAnchor,
                constant: -Drawing.imageOffset
            ),
            recipeTitle.topAnchor.constraint(
                equalTo: categoryImage.bottomAnchor,
                constant: Drawing.spacing
            ),
            recipeTitle.leftAnchor.constraint(
                equalTo: contentView.leftAnchor,
                constant: Drawing.contentOffset
            ),
            recipeTitle.rightAnchor.constraint(
                equalTo: contentView.rightAnchor,
                constant: -Drawing.contentOffset
            ),
            timeLabel.topAnchor.constraint(
                equalTo: recipeTitle.bottomAnchor,
                constant: Drawing.spacing
            ),
            timeLabel.leftAnchor.constraint(
                equalTo: contentView.leftAnchor,
                constant: Drawing.spacing
            ),
            bottomContainer.topAnchor.constraint(
                equalTo: timeLabel.bottomAnchor,
                constant: Drawing.spacing
            ),
            bottomContainer.leftAnchor.constraint(
                equalTo: contentView.leftAnchor,
                constant: Drawing.contentOffset
            ),
            bottomContainer.rightAnchor.constraint(
                equalTo: contentView.rightAnchor,
                constant: -Drawing.contentOffset
            )
        ])
    }
}

import SwiftUI
@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, xrOS 1.0, *)
#Preview {
    RecipeCategoryCell()
}
