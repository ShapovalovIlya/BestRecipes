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
    private lazy var dataSource: UICollectionViewDiffableDataSource<Section, Item> = makeDataSource()
    
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
        
        dataSource.supplementaryViewProvider = makeHeaderRegistration().headerProvider
        homeView.collectionView.dataSource = dataSource
        homeView.searchBar.delegate = self
        homeView.collectionView.delegate = self
        
        presenter.viewDidLoad()

        Logger.viewCycle.debug("HomeViewController: \(#function)")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        presenter.viewDidDisappear()
        Logger.viewCycle.debug("HomeViewController: \(#function)")
    }
    
    @objc func seeAllTrendingButtonTap() {
        presenter.seeAllButtonTap(.popularity)
    }
    
    @objc func seeAllRecentButtonTap() {
        presenter.seeAllButtonTap(.time)
    }
    
}

//MARK: - HomePresenterDelegate
extension HomeViewController: HomePresenterDelegate {
    func showLoading() {
        homeView.isLoading(true)
    }
    
    func dismissLoading() {
        homeView.isLoading(false)
    }
    
    func recipesDidLoad(_ recipes: RecipesList) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(
            recipes.trending.map(Item.trending),
            toSection: .trending
        )
        
        snapshot.appendItems(
            MealType.allCases.map(Item.categoryButtons),
            toSection: .categoryButtons
        )
        
        snapshot.appendItems(
            recipes.categoryRecipes.map(Item.categoryTitles),
            toSection: .categoryRecipes
        )
        snapshot.appendItems(
            recipes.recent.map(Item.recent),
            toSection: .recent
        )
        
        dataSource.apply(snapshot)
        homeView.isLoading(false)
    }
}

//MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if Section(rawValue: indexPath.section) != .categoryButtons {
            collectionView.deselectItem(at: indexPath, animated: true)
        }
        presenter.didSelectReceipt(at: indexPath)
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
}

extension HomeViewController {
    //MARK: - Section
    enum Section: Int, CaseIterable {
        case trending
        case categoryButtons
        case categoryRecipes
        case recent
    }
    
    enum Item: Hashable {
        case trending(Recipe)
        case categoryButtons(MealType)
        case categoryTitles(Recipe)
        case recent(Recipe)
    }
}

private extension HomeViewController {
    //MARK: - Private methods
    func makeDataSource() -> UICollectionViewDiffableDataSource<Section, Item> {
        let trendingCellRegistration = makeTrendingRecipeCellRegistration()
        let categoryButtonRegistration = makeCategoryButtonCellRegistration()
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
                
            case let .categoryButtons(category):
                return collectionView.dequeueConfiguredReusableCell(
                    using: categoryButtonRegistration,
                    for: indexPath,
                    item: category
                )
                
            case let .categoryTitles(recipe):
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
    
    func makeTrendingRecipeCellRegistration() -> UICollectionView.CellRegistration<TrendingRecipeCell, Recipe> {
        .init { cell, _, recipe in
            cell.configure(with: recipe)
        }
    }
    
    func makeCategoryButtonCellRegistration() -> UICollectionView.CellRegistration<CategoryCell, MealType> {
        .init { [selectedCategory = presenter.selectedCategory] cell, _, category in
            cell.configure(with: category)
            cell.isSelected = selectedCategory == category
        }
    }
    
    func makeCategoryRecipeCellRegistration() -> UICollectionView.CellRegistration<RecipeCategoryCell, Recipe> {
        .init { cell, _, recipe in
            cell.configure(with: recipe)
        }
    }
    
    func makeRecentRecipeCellRegistration() -> UICollectionView.CellRegistration<RecentRecipeCell, Recipe> {
        .init { cell, _, recipe in
            cell.configure(with: recipe)
        }
    }
    
    func makeHeaderRegistration() -> UICollectionView.SupplementaryRegistration<HeaderView> {
        .init(elementKind: UICollectionView.elementKindSectionHeader) { header, elementKind, indexPath in
            switch Section(rawValue: indexPath.section) {
            case .trending:
                header.configure(title: "Trending now")
                header.addButton(
                    target: self,
                    action: #selector(self.seeAllTrendingButtonTap)
                )
                
            case .categoryButtons:
                header.configure(title: "Popular category")
                
            case .recent:
                header.configure(title: "Recent recipe")
                header.addButton(
                    target: self,
                    action: #selector(self.seeAllRecentButtonTap)
                )
                
            default:
                break
            }
        }
    }
    
}







