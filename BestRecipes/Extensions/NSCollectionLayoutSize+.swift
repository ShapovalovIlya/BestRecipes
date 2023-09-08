//
//  NSCollectionLayoutSize+.swift
//  BestRecipes
//
//  Created by Илья Шаповалов on 08.09.2023.
//

import UIKit

extension NSCollectionLayoutSize {
    static let groupSize = NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1),
        heightDimension: .fractionalHeight(0.4)
    )
    
    static let headerSize = NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1.0),
        heightDimension: .estimated(44)
    )
}
