//
//  DiscoverView.swift
//  BestRecipes
//
//  Created by Леонид Турко on 08.09.2023.
//

import UIKit

protocol DiscoverViewProtocol: UIView {
    var collectionView: UICollectionView { get }
}

final class DiscoverView: UIView, DiscoverViewProtocol {
    var collectionView: UICollectionView = makeCollectionView()
    
    // MARK: - init(_:)
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(collectionView)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = bounds
    }
}

// MARK: - DiscoverView
private extension DiscoverView {
    static func makeCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: makeCollectionViewLayout()
        )
        return collectionView
    }
    
    static func makeCollectionViewLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { sectionIndex, environment in
            return self.makeListLayoutSection()
        }
    }
    
    static func makeListLayoutSection() -> NSCollectionLayoutSection {
        // Here, each item completely fills its parent group:
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        ))
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        // Each group then contains just a single item, and fills
        // the entire available width, while defining a fixed
        // height of 50 points:
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(258)
            ),
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0)
        return section
    }
}
