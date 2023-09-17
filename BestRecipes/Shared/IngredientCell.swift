//
//  IngredientCell.swift
//  BestRecipes
//
//  Created by Dmitriy Eliseev on 06.09.2023.
//

import UIKit

final class IngredientCell: UICollectionViewCell {
    //MARK: - Private properties
    private let foodImage:  UIImageView = makeImageView()
    private let nameLabel: UILabel = .makeLabel(
        font: .titleFont,
        color: .titleTextColor,
        numberOfLines: 2
    )
    private let massLabel: UILabel = .makeLabel(
        font: .subtitleFont,
        color: .subtitleColor
    )
    
    //MARK: - init(_:)
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        setSettings()
        contentView.addSubviews(
            foodImage,
            nameLabel,
            massLabel
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
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        foodImage.image = nil
    }
    
    //MARK: - Public methods
    func configure(with ingredient: Ingredient) {
        foodImage.image = UIImage(named: ingredient.image)
        nameLabel.text = ingredient.name
        massLabel.text = combineMassLabel(from: ingredient)
    }
    
    func setupTest() {
        foodImage.image = UIImage(named: "fish")
        nameLabel.text = "Fish"
        massLabel.text = "200g"
    }
    
}

private extension IngredientCell {
    struct Drawing {
        static let offset: CGFloat = 10
    }
    
    //MARK: - Private methods
    func combineMassLabel(from ingredient: Ingredient) -> String {
        [
            ingredient.measures.metric.unitShort,
            round(ingredient.measures.metric.amount).description
        ].joined(separator: " ")
    }
    
    func setSettings(){
        contentView.backgroundColor = .ingredientCellBackground
        contentView.layer.cornerRadius = 16
    }
    
    static func makeImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            foodImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Drawing.offset),
            foodImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            foodImage.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.8),
            foodImage.widthAnchor.constraint(equalTo: foodImage.heightAnchor),
            
            nameLabel.leftAnchor.constraint(equalTo: foodImage.rightAnchor, constant: Drawing.offset),
            nameLabel.centerYAnchor.constraint(equalTo: foodImage.centerYAnchor),
            nameLabel.rightAnchor.constraint(equalTo: massLabel.leftAnchor, constant: 5),
            
            massLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -Drawing.offset),
            massLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            massLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.15)
        ])
    }
}
