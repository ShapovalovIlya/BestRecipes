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
  private let presenter: DiscoverPresenterProtocol
  private lazy var dataSource = makeDataSource()
  
  
  init(discoverView: DiscoverViewProtocol, presenter: DiscoverPresenterProtocol) {
    self.discoverView = discoverView
    self.presenter = presenter
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
    discoverView.collectionView.delegate = self
    discoverView.collectionView.dataSource = dataSource
    presenter.viewDidLoad()
  }

  func makeDataSource() -> UICollectionViewDiffableDataSource<Section, Recipe> {
    UICollectionViewDiffableDataSource(
      collectionView: discoverView.collectionView,
      cellProvider: makeCellRegistration().cellProvider
    )
  }
}

extension DiscoverViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    collectionView.deselectItem(at: indexPath, animated: true)
    presenter.didSelectRecipe(at: indexPath.item)
  }
}

extension DiscoverViewController: DiscoverPresenterDelegate {
  func recipesDidLoad(_ recipes: [Recipe]) {
    var snapshot = NSDiffableDataSourceSnapshot<Section, Recipe>()
    snapshot.appendSections([.main])
    snapshot.appendItems(recipes)
    dataSource.apply(snapshot)
  }
}

private extension DiscoverViewController {
  typealias Cell = TrendingRecipeCell
  typealias CellRegistration = UICollectionView.CellRegistration<Cell, Recipe>
  
  func makeCellRegistration() -> CellRegistration {
    CellRegistration { cell, indexPath, recipe in
      cell.configure(with: recipe)
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



//  MARK: - Show Canvas
/*
 
 struct ContentViewController: UIViewControllerRepresentable {
 
 typealias UIViewControllerType = DiscoverViewController
 
 func makeUIViewController(context: Context) -> UIViewControllerType {
 return DiscoverViewController(discoverView: DiscoverView(), presenter: <#DiscoverPresenterProtocol#>)
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
 */
