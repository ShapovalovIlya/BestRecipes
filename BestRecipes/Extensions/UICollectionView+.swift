//
//  UICollectionView+.swift
//  BestRecipes
//
//  Created by Илья Шаповалов on 08.09.2023.
//

import UIKit

extension UICollectionView.SupplementaryRegistration<TitleSupplementaryView> {
    var headerProvider: (UICollectionView, String, IndexPath) -> TitleSupplementaryView {
        { collectionView, kind, indexPath in
            collectionView.dequeueConfiguredReusableSupplementary(
                using: self,
                for: indexPath
            )
        }
    }
}
