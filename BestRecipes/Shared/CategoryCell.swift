//
//  RatedRecipeCell.swift
//  BestRecipes
//
//  Created by Илья Шаповалов on 27.08.2023.
//

import UIKit

final class CategoryCell: UICollectionViewCell {
    private let title = UILabel()
    
    //MARK: - init(_:)
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .customRed
        contentView.layer.cornerRadius = 10
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        title.text = nil
    }
    
    //MARK: - Public methods
    func configure(with category: MealType) {
        title.text = category.title
    }
    
}
