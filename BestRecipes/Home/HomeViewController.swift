//
//  HomeViewController.swift
//  Best Recipes
//
//  Created by Илья Шаповалов on 27.08.2023.
//

import UIKit
import OSLog

final class HomeViewController: UIViewController {
    //MARK: - Private properties
    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: HomeViewController.self)
    )
    private let homeView: HomeViewProtocol
    private let presenter: HomePresenterProtocol
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
    
    //MARK: - Public properties
    
    //MARK: - init(_:)
    init(
        homeView: HomeViewProtocol,
        presenter: HomePresenterProtocol
    ) {
        self.homeView = homeView
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
        
        self.dataSource = self.maleDataSource()
        
        logger.debug("Initialized")
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Deinit
    deinit {
        logger.debug("Deinitialized")
    }
    
    //MARK: - Life Cycle
    override func loadView() {
        self.view = homeView
        
        logger.debug("View loaded")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.homeView.collectionView.dataSource = dataSource
        
        presenter.viewDidLoad()
        logger.debug("View did load")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        presenter.viewDidDisappear()
    }
    
}

//MARK: - HomePresenterDelegate
extension HomeViewController: HomePresenterDelegate {
    func recipesDidLoad(_ recipes: RecipesList) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        
        snapshot.appendSections(Section.allCases)
        
        snapshot.appendItems(
            recipes.trending.map(Item.trending),
            toSection: .trending
        )
        snapshot.appendItems(
            recipes.popular.map(Item.popular),
            toSection: .popular
        )
        snapshot.appendItems(
            recipes.recent.map(Item.recent),
            toSection: .recent
        )
        snapshot.appendItems(
            recipes.creators.map(Item.creators),
            toSection: .creators
        )
        
        dataSource?.apply(snapshot)
    }
}

//MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    
}

private extension HomeViewController {
    //MARK: - Section
    enum Section: Int, CaseIterable {
        case trending
        case popular
        case recent
        case creators
    }
    
    enum Item: Hashable {
        case trending(Recipe)
        case popular(Recipe)
        case recent(Recipe)
        case creators(Recipe)
    }
    
    //MARK: - Private methods
    func maleDataSource() -> UICollectionViewDiffableDataSource<Section, Item> {
        .init(collectionView: homeView.collectionView) { collectionView, indexPath, item in
            switch item {
            case let .trending(recipe):
                collectionView.dequeueConfiguredReusableCell(
                    using: self.makeRecipeCellRegistration(),
                    for: indexPath,
                    item: recipe)
                
            case let .popular(recipe):
                collectionView.dequeueConfiguredReusableCell(
                    using: self.makeRecipeCellRegistration(),
                    for: indexPath,
                    item: recipe)
                
            case let .recent(recipe):
                collectionView.dequeueConfiguredReusableCell(
                    using: self.makeRecipeCellRegistration(),
                    for: indexPath,
                    item: recipe)
                
            case let .creators(recipe):
                collectionView.dequeueConfiguredReusableCell(
                    using: self.makeRecipeCellRegistration(),
                    for: indexPath,
                    item: recipe)
                
            }
        }
    }
    
    func foo() -> UICollectionView.SupplementaryRegistration<HomeHeader> {
        .init(elementKind: "Header") { supplementaryView, elementKind, indexPath in
            if Section(rawValue: indexPath.section) == .trending {
                
                supplementaryView.set(title: "Some title")
            }
        }
    }
    
    func makeRecipeCellRegistration() -> UICollectionView.CellRegistration<RatedRecipeCell, Recipe> {
        .init { cell, indexPath, recipe in
            cell.configure(with: recipe)
        }
    }
    
    func makeCreatorCellRegistration() -> UICollectionView.CellRegistration<CreatorCell, Recipe> {
        .init { cell, indexPath, recipe in
            cell.configure(recipe)
        }
    }
}

class HomeHeader: UICollectionReusableView {
    func set(title: String) {
        
    }
}

class TrendingCell: UICollectionViewCell {
    
}

class PopularCell: UICollectionViewCell {
    
}

class RecentCell: UICollectionViewCell {
    
}

class CreatorCell: UICollectionViewCell {
    func configure(_ model: Recipe) {
        
    }
}

