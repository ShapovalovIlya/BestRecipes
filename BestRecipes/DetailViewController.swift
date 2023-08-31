//
//  DetailViewController.swift
//  BestRecipes
//
//  Created by Леонид Турко on 30.08.2023.
//

import UIKit
import SwiftUI

enum Section: Int, CaseIterable {
  case main
  case additinal
  case all
}

class DetailViewController: UIViewController {

  private lazy var collectionView = makeCollectionView()
  private var dataSource: UICollectionViewDiffableDataSource<Section, Product>!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureDataSource()
    view.addSubview(collectionView)
  }
  
  func makeCollectionView() -> UICollectionView {
    let collectionView = UICollectionView(
      frame: .zero,
      collectionViewLayout: configureLayout()
    )
    collectionView.frame = view.bounds
    collectionView.register(NumberCell.self, forCellWithReuseIdentifier: NumberCell.reuseIdentifier)
    return collectionView
  }

  func configureLayout() -> UICollectionViewCompositionalLayout {
    let spacing: CGFloat = 10
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(44))
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    
    let section = NSCollectionLayoutSection(group: group)
    section.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
    return UICollectionViewCompositionalLayout(section: section)
  }
  
  func configureDataSource() {
    dataSource = UICollectionViewDiffableDataSource<Section, Product>(collectionView: collectionView) { (collectionView, indexPath, product) -> UICollectionViewCell? in
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NumberCell.reuseIdentifier, for: indexPath) as? NumberCell else { fatalError() }
      cell.nameLabel.text = product.name
      cell.backgroundColor = .systemPink
      return cell
    }
    
    var initialSnapshot = NSDiffableDataSourceSnapshot<Section, Product>()
    let list = ProductList()
    initialSnapshot.appendSections(Section.allCases)
    initialSnapshot.appendItems(list.featured, toSection: .main)
    initialSnapshot.appendItems(list.onSale, toSection: .additinal)
    initialSnapshot.appendItems(list.all, toSection: .all)
    
    
    dataSource.apply(initialSnapshot, animatingDifferences: false)
    
  }
}

struct ContentViewController: UIViewControllerRepresentable {
  
  typealias UIViewControllerType = DetailViewController
  
  func makeUIViewController(context: Context) -> UIViewControllerType {
    return DetailViewController()
  }
  
  func updateUIViewController(_ uiViewController: DetailViewController, context: Context) {}
}

struct ContentViewController_Previews: PreviewProvider {
  static var previews: some View {
    ContentViewController()
      .edgesIgnoringSafeArea(.all)
      .colorScheme(.light) // or .dark
  }
}
