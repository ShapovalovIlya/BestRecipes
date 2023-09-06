//
//  RatedRecipeCell.swift
//  BestRecipes
//
//  Created by Илья Шаповалов on 27.08.2023.
//

import UIKit

final class CategoryCell: UICollectionViewCell {
    
    var textLabel = UILabel()
    
    
    
    //MARK: - Public methods
    static let cellId = "CategoryCellId"
    
    //MARK: - Private methods
    
    //MARK: - init(_:)
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        backgroundColor = .red
        addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        textLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
       
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public methods
    func configure(with recipe: Product) {
        textLabel.text = recipe.name
        textLabel.textColor = .black
    }
    
}
