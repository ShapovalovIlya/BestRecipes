//
//  RecentRecipeCell.swift
//  BestRecipes
//
//  Created by Dmitriy Eliseev on 06.09.2023.
//

import UIKit

struct ImageDrawing {
    var imageName:String
    var imageSize: CGSize
    var radiusImage: CGFloat
}

struct StackDrawing {
    var offset: BoundBox
    var spacing: CGFloat
}

struct BoundBox {
    var leading: CGFloat
    var trailing: CGFloat
    var top: CGFloat
    var bottom: CGFloat
}

final class RecentRecipeCell: UICollectionViewCell {
    private struct Drawing {
        static let imageHeight: CGFloat = 124
    }
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
        
        setupTest()
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
}

//MARK: - Private extensions
private extension RecentRecipeCell {
    func setupTest() {
        recipeImage.image = UIImage(named: "foodPhoto")
        recipeTitle.text = "Kelewele Ghanian Recipe"
        creatorTitle.text = "By Zeelicious Foods"
    }
    
    static func makeImageView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            // recipeImage
            recipeImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            recipeImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            recipeImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            recipeImage.heightAnchor.constraint(equalToConstant: Drawing.imageHeight),
            // recipeTitle
            recipeTitle.topAnchor.constraint(equalTo: recipeImage.bottomAnchor, constant: 10),
            recipeTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            recipeTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            creatorTitle.topAnchor.constraint(equalTo: recipeTitle.bottomAnchor, constant: 10),
            creatorTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            creatorTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}

import SwiftUI
@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, xrOS 1.0, *)
#Preview {
    RecentRecipeCell()
}
