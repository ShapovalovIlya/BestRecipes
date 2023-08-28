//
//  RatedRecipeCell.swift
//  BestRecipes
//
//  Created by Илья Шаповалов on 27.08.2023.
//

import UIKit

final class RatedRecipeCell: UICollectionViewCell {
    //MARK: - Public methods
    static let cellId = "RatedRecipeCellId"
    
    //MARK: - Private methods
    
    //MARK: - init(_:)
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public methods
    func configure(with recipe: Recipe) {
        
    }
    
}
