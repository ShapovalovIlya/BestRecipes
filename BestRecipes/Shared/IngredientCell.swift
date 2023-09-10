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
        color: .titleTextColor
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
        setupTest()
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
    //MARK: - Private methods
    func combineMassLabel(from ingredient: Ingredient) -> String {
        [
            ingredient.amount.unit,
            ingredient.amount.value.description
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
            foodImage.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            foodImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            foodImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            foodImage.widthAnchor.constraint(equalTo: foodImage.heightAnchor),
            
            nameLabel.leftAnchor.constraint(equalTo: foodImage.rightAnchor, constant: 10),
            nameLabel.centerXAnchor.constraint(equalTo: foodImage.centerXAnchor),
            
            massLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            massLabel.centerXAnchor.constraint(equalTo: foodImage.centerXAnchor)
        ])
    }
}