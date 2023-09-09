//
//  RecipeCategoryCell.swift
//  BestRecipes
//
//  Created by Dmitriy Eliseev on 06.09.2023.
//

import UIKit

final class RecipeCategoryCell: UICollectionViewCell {
    let bookmarkButton: UIButton = .makeButtonBookmark()
    
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
        font: .subtitleFont,
        color: .titleTextColor
    )
    
    private let grayBackground: UIView = makeBackground()
    
    //MARK: - init(_:)
    override init(frame: CGRect) {
        super .init(frame: frame)
        contentView.clipsToBounds = true
        timeLabel.text = "Time"
        
        contentView.addSubviews(
            grayBackground,
            categoryImage,
            recipeTitle,
            timeLabel,
            timeTextLabel,
            bookmarkButton
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life Cycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupConstraints()
        layoutIfNeeded()
        categoryImage.layer.cornerRadius = categoryImage.frame.height * 0.5
        bookmarkButton.layer.cornerRadius = bookmarkButton.frame.height * 0.5
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
    private struct Drawing {
        static let imageOffset: CGFloat = 22
        static let contentOffset: CGFloat = 12
        static let spacing: CGFloat = 10
    }
    
    static func makeImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
    
    static func makeBackground() -> UIView {
        let background = UIView()
        background.backgroundColor = .categoryBackground
        background.layer.cornerRadius = 8
        background.translatesAutoresizingMaskIntoConstraints = false
        return background
    }
   
    func setupConstraints() {
        NSLayoutConstraint.activate([
            grayBackground.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            grayBackground.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            grayBackground.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            grayBackground.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.75),
            
            categoryImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
            categoryImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            categoryImage.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.47),
            categoryImage.widthAnchor.constraint(equalTo: categoryImage.heightAnchor),
            
            recipeTitle.topAnchor.constraint(equalTo: categoryImage.bottomAnchor, constant: Drawing.spacing),
            recipeTitle.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Drawing.contentOffset),
            recipeTitle.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -Drawing.contentOffset),
            
            timeLabel.topAnchor.constraint(equalTo: recipeTitle.bottomAnchor, constant: Drawing.spacing),
            timeLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Drawing.spacing),
            
            timeTextLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor,constant: Drawing.spacing),
            timeTextLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Drawing.contentOffset),
            
            bookmarkButton.centerYAnchor.constraint(equalTo: timeTextLabel.centerYAnchor),
            bookmarkButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -Drawing.contentOffset),
            bookmarkButton.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.15),
            bookmarkButton.widthAnchor.constraint(equalTo: bookmarkButton.heightAnchor)
        ])
    }
}
