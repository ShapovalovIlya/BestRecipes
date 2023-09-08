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
    
    
    //MARK: - Public properties
    
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
        
        dataSource = self.makeDataSource()
        dataSource?.supplementaryViewProvider = makeHeaderRegistration().headerProvider
        homeView.searchBar.delegate = self
        
        presenter.viewDidLoad()
        
        Logger.viewCycle.debug("HomeViewController: \(#function)")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        presenter.viewDidDisappear()
        Logger.viewCycle.debug("HomeViewController: \(#function)")
    }
    
}

//MARK: - HomePresenterDelegate
extension HomeViewController: HomePresenterDelegate {
    func recipesDidLoad(_ recipes: RecipesList) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        
//        snapshot.appendSections(Section.allCases)
//        snapshot.appendItems(
//            recipes.map(Item.recipe),
//            toSection: .creators
//        )
//        snapshot.appendItems(
//            recipes.map(Item.category),
//            toSection: .popular
//        )
        
//        snapshot.appendItems(
//            recipes.map(Item.recipe),
//            toSection: .creators
//        )
//        snapshot.appendItems(
//            recipes.map(Item.recipe),
//            toSection: .trending
//        )
        
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
        case popular
        case recent
        case creators
    }
    
    enum Item: Hashable {
        case recipe(Recipe)
        
        
    }
    
    //MARK: - Private methods
    func makeDataSource() -> UICollectionViewDiffableDataSource<Section, Item> {
        let cellRegistration = makeRecipeCellRegistration()
        let categoryRegistration = makeCategoryCellRegistration()
 //       let creatorsRegistration = makeCreatorsCellRegistration()
        
        return UICollectionViewDiffableDataSource(collectionView: homeView.collectionView) { collectionView, indexPath, item in
            switch item {
            case .recipe(let recipe):
                return collectionView.dequeueConfiguredReusableCell(
                    using: cellRegistration,
                    for: indexPath,
                    item: recipe
                )
                
//            case .category(let category):
//                return collectionView.dequeueConfiguredReusableCell(
//                    using: categoryRegistration,
//                    for: indexPath,
//                    item: category
//                )
//                
//            case .creators(let creators):
//                return collectionView.dequeueConfiguredReusableCell(
//                    using: creatorsRegistration,
//                    for: indexPath,
//                    item: creators
//                )
//                
           }
            
        }
        
    }
}

private extension HomeViewController {
    func makeRecipeCellRegistration() -> UICollectionView.CellRegistration<UICollectionViewCell, Recipe> {
        .init { cell, indexPath, recipe in
            cell.backgroundColor = .red
        }
    }
    
    func makeCategoryCellRegistration() -> UICollectionView.CellRegistration<UICollectionViewCell, Recipe> {
        .init { cell, indexPath, category in
            cell.backgroundColor = .green
        }
    }
    
//    func makeCreatorsCellRegistration() -> UICollectionView.CellRegistration<RatedRecipeCell, Creators> {
//        .init { cell, indexPath, recipe in
//            //        cell.configure(with: recipe)
//            cell.backgroundColor = .cyan
//        }
//    }
    
    func makeHeaderRegistration() -> UICollectionView.SupplementaryRegistration<TitleSupplementaryView> {
        .init(elementKind: UICollectionView.elementKindSectionHeader) { supplementaryView, elementKind, indexPath in
                let tutorialCollection = ["Trending now", "Popular category", "Recent recipe", "Creators"]
                switch Section(rawValue: indexPath.section) {
                case .trending:
                    supplementaryView.textLabel.text = tutorialCollection[indexPath.section]
                    
                case .popular:
                    supplementaryView.textLabel.text = tutorialCollection[indexPath.section]
                    
                case .recent:
                    supplementaryView.textLabel.text = tutorialCollection[indexPath.section]
                    
                case .creators:
                    supplementaryView.textLabel.text = tutorialCollection[indexPath.section]
                    
                default:
                    break
                }
            }
    }
    
}

extension UICollectionView.SupplementaryRegistration<TitleSupplementaryView> {
    var headerProvider: (UICollectionView, String, IndexPath) -> TitleSupplementaryView {
        { collectionView, kind, indexPath in
            collectionView.dequeueConfiguredReusableSupplementary(
                using: self,
                for: indexPath)
        }
    }
}







