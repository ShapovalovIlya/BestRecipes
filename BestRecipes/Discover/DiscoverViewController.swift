//
//  DiscoverViewController.swift
//  BestRecipes
//
//  Created by Леонид Турко on 07.09.2023.
//

import UIKit

class DiscoverViewController: UIViewController {
    // MARK: - Private properties
    private let discoverView: DiscoverViewProtocol
    private let presenter: DiscoverPresenterProtocol
    private lazy var dataSource = makeDataSource()
    
    // MARK: - init(_:)
    init(
        discoverView: DiscoverViewProtocol,
        presenter: DiscoverPresenterProtocol
    ) {
        self.discoverView = discoverView
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func loadView() {
        self.view = discoverView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        discoverView.collectionView.delegate = self
        discoverView.collectionView.dataSource = dataSource
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.viewWillAppear()
    }
    
}

// MARK: - UICollectionViewDelegate
extension DiscoverViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        presenter.didSelectRecipe(at: indexPath.item)
    }
}

// MARK: - DiscoverPresenterDelegate
extension DiscoverViewController: DiscoverPresenterDelegate {
    func recipesDidLoad(_ recipes: [Recipe]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Recipe>()
        snapshot.appendSections([.main])
        snapshot.appendItems(recipes)
        dataSource.apply(snapshot)
    }
}

private extension DiscoverViewController {
    enum Section {
        case main
    }
    
    typealias Cell = TrendingRecipeCell
    typealias CellRegistration = UICollectionView.CellRegistration<Cell, Recipe>
    
    func makeDataSource() -> UICollectionViewDiffableDataSource<Section, Recipe> {
        UICollectionViewDiffableDataSource(
            collectionView: discoverView.collectionView,
            cellProvider: makeCellRegistration().cellProvider
        )
    }
    
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

