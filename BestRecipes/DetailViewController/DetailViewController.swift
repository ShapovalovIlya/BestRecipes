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

final class DetailViewController: UIViewController {
  
  private let detailView: DetailViewProtocol
  private lazy var dataSource = makeDataSource()
  
  
  let list = ProductList()
  
  // MARK: - inits
  init(detailView: DetailViewProtocol) {
    self.detailView = detailView
    super.init(nibName: nil, bundle: nil)
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //  MARK: - Life Cycle
  override func loadView() {
    self.view = detailView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    detailView.collectionView.register(
      TitleSupplementaryView.self,
      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
      withReuseIdentifier: TitleSupplementaryView.reuseIdentifier
    )
    detailView.collectionView.dataSource = dataSource
    productListDidLoad(list)
    
  }
  
  func makeDataSource() -> UICollectionViewDiffableDataSource<Section, Product> {
    UICollectionViewDiffableDataSource(
      collectionView: detailView.collectionView,
      cellProvider: makeCellRegistration().cellProvider
    )
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
    return DetailViewController(detailView: DetailView())
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
