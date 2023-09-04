//
//  DetailView.swift
//  BestRecipes
//
//  Created by Леонид Турко on 04.09.2023.
//

import UIKit

protocol DetailViewProtocol: UIView {
  var collectionView: UICollectionView { get }
}

final class DetailView: UIView, DetailViewProtocol {
  let collectionView = makeCollectionView()
  
  
  
  // MARK: - init
  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubview(collectionView)
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //  MARK: - Life Cycle
  override func layoutSubviews() {
    super.layoutSubviews()
    collectionView.frame = bounds
  }
}

//  MARK: -  Private Methods
private extension DetailView {
  
static func makeCollectionView() -> UICollectionView {
    let collectionView = UICollectionView(
      frame: .zero,
      collectionViewLayout: makeCollectionViewLayout()
    )
    collectionView.register(NumberCell.self, forCellWithReuseIdentifier: NumberCell.reuseIdentifier)
    return collectionView
  }
  
  static func makeCollectionViewLayout() -> UICollectionViewLayout {
    UICollectionViewCompositionalLayout { sectionIndex, environment in
      
      switch Section(rawValue: sectionIndex) {
      case .main, .additinal:
        return makeGridLayoutSection()
      case .all:
        return makeListLayoutSection()
      case nil:
        return nil
      }
    }
  }
  
  static func makeGridLayoutSection() -> NSCollectionLayoutSection {
    // Each item will take up half of the width of the group
    // that contains it, as well as the entire available height:
    let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(0.5),
      heightDimension: .fractionalHeight(1)
    ))
    item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
    
    //Each group will then take up the entire available
    //width, and set its height to half of that width, to
    //make each item square-shaped:
    let group = NSCollectionLayoutGroup.horizontal(
      layoutSize: NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1),
        heightDimension: .fractionalWidth(0.5)
      ),
      subitem: item,
      count: 2
    )
    
    let section = NSCollectionLayoutSection(group: group)
    section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0)
    
    let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
    let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
    section.boundarySupplementaryItems = [sectionHeader]
    return section
  }
  
  static func makeListLayoutSection() -> NSCollectionLayoutSection {
    // Here, each item completely fills its parent group:
    let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1),
      heightDimension: .fractionalHeight(1)
    ))
    item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0)
    
    // Each group then contains just a single item, and fills
    // the entire available width, while defining a fixed
    // height of 50 points:
    let group = NSCollectionLayoutGroup.vertical(
      layoutSize: NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1),
        heightDimension: .absolute(100)
      ),
      subitems: [item]
    )
    let section = NSCollectionLayoutSection(group: group)
    
    section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0)
    
    let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
    let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
    section.boundarySupplementaryItems = [sectionHeader]
    return section
  }
}
