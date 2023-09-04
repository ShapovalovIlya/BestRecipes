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
  private lazy var dataSource = makeDataSource()
  
  let list = ProductList()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.register(TitleSupplementaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleSupplementaryView.reuseIdentifier)
    collectionView.dataSource = dataSource
    view.addSubview(collectionView)
    productListDidLoad(list)
  }
  
  func makeCollectionView() -> UICollectionView {
    let collectionView = UICollectionView(
      frame: .zero,
      collectionViewLayout: makeCollectionViewLayout()
    )
    collectionView.frame = view.bounds
    collectionView.register(NumberCell.self, forCellWithReuseIdentifier: NumberCell.reuseIdentifier)
    return collectionView
  }
  
  func makeDataSource() -> UICollectionViewDiffableDataSource<Section, Product> {
    UICollectionViewDiffableDataSource(
      collectionView: collectionView,
      cellProvider: makeCellRegistration().cellProvider
    )
  }
}

private extension DetailViewController {
  func makeCollectionViewLayout() -> UICollectionViewLayout {
    UICollectionViewCompositionalLayout {
      [weak self] sectionIndex, environment in
      
      switch Section(rawValue: sectionIndex) {
      case .main, .additinal:
        return self?.makeGridLayoutSection()
      case .all:
        return self?.makeListLayoutSection()
      case nil:
        return nil
      }
    }
  }
}

private extension DetailViewController {
  func makeGridLayoutSection() -> NSCollectionLayoutSection {
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
}

private extension DetailViewController {
  func makeListLayoutSection() -> NSCollectionLayoutSection {
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

private extension DetailViewController {
  typealias Cell = NumberCell
  typealias CellRegistration = UICollectionView.CellRegistration<Cell, Product>
  
  func makeCellRegistration() -> CellRegistration {
    CellRegistration { cell, indexPath, product in
      cell.configure(with: product)
      cell.backgroundColor = .systemPink
    }
  }
  
  func makeHeaderRegistraition() -> UICollectionView.SupplementaryRegistration<TitleSupplementaryView> {
    .init(
      elementKind: UICollectionView.elementKindSectionHeader) { supplementaryView, elementKind, indexPath in
        let tutorialCollection = ["How to cook", "Instructions", "Ingridients"]
        switch Section(rawValue: indexPath.section) {
        case .main:
          
          supplementaryView.textLabel.text = tutorialCollection[indexPath.section]
          
        case .additinal:
          supplementaryView.textLabel.text = tutorialCollection[indexPath.section]
          
        case .all:
          supplementaryView.textLabel.text = tutorialCollection[indexPath.section]
          supplementaryView.numberLabel.text = "\(tutorialCollection.count) items"
        case nil:
          break
        }
      }
  }
  
}

private extension UICollectionView.CellRegistration {
  var cellProvider: (UICollectionView, IndexPath, Item) -> Cell {
    return { collectionView, indexPath, product in
      collectionView.dequeueConfiguredReusableCell(
        using: self,
        for: indexPath,
        item: product
      )
    }
  }
}

private extension DetailViewController {
  func productListDidLoad(_ list: ProductList) {
    var snapshot = NSDiffableDataSourceSnapshot<Section, Product>()
    snapshot.appendSections(Section.allCases)
    snapshot.appendItems(list.featured, toSection: .main)
    snapshot.appendItems(list.onSale, toSection: .additinal)
    snapshot.appendItems(list.all, toSection: .all)
    
    dataSource.apply(snapshot)
    
    dataSource.supplementaryViewProvider =  { (collectionView: UICollectionView, kind: String, indexPath: IndexPath) in

      if let titleSupplementayView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleSupplementaryView.reuseIdentifier, for: indexPath) as? TitleSupplementaryView {
        let tutorialCollection = ["How to cook", "Instructions", "Ingridients"]
        switch Section(rawValue: indexPath.section) {
        case .main:

          titleSupplementayView.textLabel.text = tutorialCollection[indexPath.section]
          return titleSupplementayView

        case .additinal:
          titleSupplementayView.textLabel.text = tutorialCollection[indexPath.section]
          return titleSupplementayView

        case .all:
          titleSupplementayView.textLabel.text = tutorialCollection[indexPath.section]
          titleSupplementayView.numberLabel.text = "\(tutorialCollection.count) items"
          return titleSupplementayView
        case nil:
          return nil
        }

      } else {
        return nil
      }
  }
  }
  
}

//  MARK: - Show Canvas
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
