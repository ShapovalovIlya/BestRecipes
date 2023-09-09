//
//  DiscoverViewController.swift
//  BestRecipes
//
//  Created by Леонид Турко on 07.09.2023.
//

import UIKit
import SwiftUI

enum Section {
  case main
}

class DiscoverViewController: UIViewController {
  private let discoverView: DiscoverViewProtocol
  private lazy var dataSource = makeDataSource()
  
  init(discoverView: DiscoverViewProtocol) {
    self.discoverView = discoverView
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    self.view = discoverView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    discoverView.collectionView.dataSource = dataSource
    productListDidLoad(Array(1...10))
  }

  func makeDataSource() -> UICollectionViewDiffableDataSource<Section, Int> {
    UICollectionViewDiffableDataSource(
      collectionView: discoverView.collectionView,
      cellProvider: makeCellRegistration().cellProvider
    )
  }
}

private extension DiscoverViewController {
  typealias Cell = DiscoverCell
  typealias CellRegistration = UICollectionView.CellRegistration<Cell, Int>
  
  func makeCellRegistration() -> CellRegistration {
    CellRegistration { cell, indexPath, number in
      cell.configure(with: number)
      cell.backgroundColor = .green
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

private extension DiscoverViewController {
  func productListDidLoad(_ list: [Int]) {
    var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
    snapshot.appendSections([.main])
    snapshot.appendItems(list)
    dataSource.apply(snapshot)
  }
}

//  MARK: - Show Canvas
struct ContentViewController: UIViewControllerRepresentable {
  
  typealias UIViewControllerType = DiscoverViewController
  
  func makeUIViewController(context: Context) -> UIViewControllerType {
    return DiscoverViewController(discoverView: DiscoverView())
  }
  
  func updateUIViewController(_ uiViewController: DiscoverViewController, context: Context) {}
}

struct ContentViewController_Previews: PreviewProvider {
  static var previews: some View {
    ContentViewController()
      .edgesIgnoringSafeArea(.all)
      .colorScheme(.light) // or .dark
  }
}
