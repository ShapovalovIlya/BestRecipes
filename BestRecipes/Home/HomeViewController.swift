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
    private let homeView: HomeViewProtocol
    private let presenter: HomePresenterProtocol
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
    
    //MARK: - init(_:)
    init(
        homeView: HomeViewProtocol,
        presenter: HomePresenterProtocol
    ) {
        self.homeView = homeView
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
        Logger.viewCycle.debug("HomeViewController: \(#function)")
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Deinit
    deinit {
        Logger.viewCycle.debug("HomeViewController: \(#function)")
    }
    
    //MARK: - Life Cycle
    override func loadView() {
        self.view = homeView
        homeView.frame = self.view.bounds
        
        Logger.viewCycle.debug("HomeViewController: \(#function)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = makeDataSource()
        dataSource?.supplementaryViewProvider = makeHeaderRegistration().headerProvider
        homeView.searchBar.delegate = self
        
        presenter.viewDidLoad()
        recipesDidLoad(.sample)
        Logger.viewCycle.debug("HomeViewController: \(#function)")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        presenter.viewDidDisappear()
        Logger.viewCycle.debug("HomeViewController: \(#function)")
    }
    
    @objc func seeAllTrandingButtonTap() {
        print(#function)
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
            recipes.category.map(Item.category),
            toSection: .category
        )
        snapshot.appendItems(
            recipes.recent.map(Item.recent),
            toSection: .recent
        )
        
        dataSource?.apply(snapshot)
    }
}

//MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    
}

extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
 //       presenter.searchTextDidChange(searchText)
        
    }
}

extension HomeViewController {
    //MARK: - Section
    enum Section: Int, CaseIterable {
        case trending
        case category
        case recent
    }
    
    enum Item: Hashable {
        case trending(Recipe)
        case category(Recipe)
        case recent(Recipe)
    }
    
    //MARK: - Private methods
    func makeDataSource() -> UICollectionViewDiffableDataSource<Section, Item> {
        let trendingCellRegistration = makeTrendingRecipeCellRegistration()
        let categoryCellRegistration = makeCategoryRecipeCellRegistration()
        let recentCellRegistration = makeRecentRecipeCellRegistration()
        
        return .init(collectionView: homeView.collectionView) { collectionView, indexPath, item in
            switch item {
            case let .trending(recipe):
                return collectionView.dequeueConfiguredReusableCell(
                    using: trendingCellRegistration,
                    for: indexPath,
                    item: recipe
                )
                
            case let .category(recipe):
                return collectionView.dequeueConfiguredReusableCell(
                    using: categoryCellRegistration,
                    for: indexPath,
                    item: recipe
                )
                
            case let .recent(recipe):
                return collectionView.dequeueConfiguredReusableCell(
                    using: recentCellRegistration,
                    for: indexPath,
                    item: recipe
                )
            }
        }
    }
        
}


private extension HomeViewController {
    func makeTrendingRecipeCellRegistration() -> UICollectionView.CellRegistration<TrendingRecipeCell, Recipe> {
        .init { cell, indexPath, recipe in
            cell.setupTest()
        }
    }
    
    func makeCategoryRecipeCellRegistration() -> UICollectionView.CellRegistration<RecipeCategoryCell, Recipe> {
        .init { cell, indexPath, itemIdentifier in
            cell.setupTest()
        }
    }
    
    func makeRecentRecipeCellRegistration() -> UICollectionView.CellRegistration<RecentRecipeCell, Recipe> {
        .init { cell, indexPath, itemIdentifier in
            cell.setupTest()
        }
    }
    
    func makeHeaderRegistration() -> UICollectionView.SupplementaryRegistration<HeaderView> {
        .init(elementKind: UICollectionView.elementKindSectionHeader) { header, elementKind, indexPath in
            let titles = ["Trending now", "Popular category", "Recent recipe", "Creators"]
            let title = titles[indexPath.section]
            
            switch Section(rawValue: indexPath.section) {
            case .trending:
                header.configure(title: title)
                header.addButton(
                    target: self,
                    action: #selector(self.seeAllTrandingButtonTap)
                )
                
            case .category:
                header.configure(title: title)
                
            case .recent:
                header.configure(title: title)
                
            default:
                break
            }
        }
    }
    
}







