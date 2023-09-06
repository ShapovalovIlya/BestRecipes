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
        
        self.dataSource = self.makeDataSource()
        
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
        homeView.frame = self.view.bounds
        logger.debug("View loaded")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
        logger.debug("View did load")
        self.homeView.searchBar.delegate = self
        
        let recipesArray = Recipe.sample
        recipesDidLoad(recipesArray)
        
        
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        presenter.viewDidDisappear()
    }
    
}

//MARK: - HomePresenterDelegate
extension HomeViewController: HomePresenterDelegate {
    func recipesDidLoad(_ recipes: [Product]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(
            recipes.map(Item.recipe),
            toSection: .creators
        )
        snapshot.appendItems(
            recipes.map(Item.category),
            toSection: .popular
        )
        
        snapshot.appendItems(
            recipes.map(Item.recipe),
            toSection: .creators
        )
        snapshot.appendItems(
            recipes.map(Item.recipe),
            toSection: .trending
        )
        
        dataSource?.apply(snapshot)
        dataSource?.supplementaryViewProvider = { (collectionView: UICollectionView, kind: String, indexPath: IndexPath) in
            if let titleSupplementaryView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleSupplementaryView.reuseIdentifier, for: indexPath) as? TitleSupplementaryView {
                
                let tutorialCollection = ["Trending now", "Popular category", "Recent recipe", "Creators"]
                switch Section(rawValue: indexPath.section) {
                    
                case .trending:
                    titleSupplementaryView.textLabel.text = tutorialCollection[indexPath.section]
                    titleSupplementaryView.seeAllButton.titleLabel?.text = "See all ->"
                    return titleSupplementaryView
                case .popular:
                    titleSupplementaryView.textLabel.text = tutorialCollection[indexPath.section]
                    return titleSupplementaryView
                    
                case .recent:
                    titleSupplementaryView.textLabel.text = tutorialCollection[indexPath.section]
                    titleSupplementaryView.seeAllButton.titleLabel?.text = "See all ->"
                    return titleSupplementaryView
                case .creators:
                    titleSupplementaryView.textLabel.text = tutorialCollection[indexPath.section]
                    titleSupplementaryView.seeAllButton.titleLabel?.text = "See all ->"
                    return titleSupplementaryView
                    
                case nil:
                    return nil
                    
                }
            } else {
                return nil
            }
        }
        
    }
}

//MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    
}

extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.searchTextDidChange(searchText)
        
    }
}

//var numberOfSections =

extension HomeViewController {
    //MARK: - Section
    enum Section: Int, CaseIterable {
        case trending
        case popular
        case recent
        case creators
    }
    
    enum Item: Hashable {
        case recipe(Product)
        case creators(Creators)
        case category(Product)
    }
    
    //MARK: - Private methods
    
    func makeDataSource() -> UICollectionViewDiffableDataSource<Section, Item> {
        
        let cellRegistration = makeRecipeCellRegistration()
        let categoryRegistration = makeCategoryCellRegistration()
        let creatorsRegistration = makeCreatorsCellRegistration()
        
        return UICollectionViewDiffableDataSource(collectionView: homeView.collectionView) { collectionView, indexPath, item in
            switch item {
            case .recipe(let recipe):
                return collectionView.dequeueConfiguredReusableCell(
                    using: cellRegistration,
                    for: indexPath,
                    item: recipe
                )
                
            case .category(let category):
                return collectionView.dequeueConfiguredReusableCell(
                    using: categoryRegistration,
                    for: indexPath,
                    item: category
                )
                
            case .creators(let creators):
                return collectionView.dequeueConfiguredReusableCell(
                    using: creatorsRegistration,
                    for: indexPath,
                    item: creators
                )
                
            }
            
        }
        
    }
}


struct Product: Hashable {
    let name: String
    let imageName: String
}


struct Cat: Hashable {
    let name: String
    let imageName: String
}
struct ProductList: Hashable {
    
    let trending = [
        Product(name: "itemOne", imageName: "sun.haze"),
        Product(name: "itemTwo", imageName: "sun.haze"),
        Product(name: "itemThree", imageName: "sun.haze"),
        Product(name: "itemFour", imageName: "sun.haze"),
        Product(name: "itemFive", imageName: "sun.haze"),
        Product(name: "itemSix", imageName: "sun.haze")
    ]
    
    let popular = [
        Product(name: "1", imageName: "moon"),
        Product(name: "2", imageName: "moon"),
        Product(name: "3", imageName: "moon"),
        Product(name: "4", imageName: "moon")
    ]
    
    let recent = [
        Product(name: "one", imageName: "dollarsign.circle.fill"),
        Product(name: "two", imageName: "dollarsign.circle.fill"),
        Product(name: "three", imageName: "dollarsign.circle.fill"),
        Product(name: "four", imageName: "dollarsign.circle.fill"),
        Product(name: "five", imageName: "dollarsign.circle.fill"),
        Product(name: "six", imageName: "dollarsign.circle.fill"),
        Product(name: "seven", imageName: "dollarsign.circle.fill"),
        Product(name: "eight", imageName: "dollarsign.circle.fill")
    ]
    
    let creators = [
        Product(name: "Eldar", imageName: "dollarsign.circle.fill"),
        Product(name: "Leo", imageName: "dollarsign.circle.fill"),
        Product(name: "Max", imageName: "dollarsign.circle.fill"),
        
    ]
}






private extension HomeViewController {
    typealias RecipeCell = RatedRecipeCell
    typealias Category = CategoryCell
    //        typealias Creators = CreatorsCell
    
    //      typealias CellRegistration = UICollectionView.CellRegistration<Cell, Product>
    
    
    func makeRecipeCellRegistration() -> UICollectionView.CellRegistration<RecipeCell, Product> {
        .init { cell, indexPath, recipe in
            cell.configure(with: recipe)
            cell.backgroundColor = .red
            
            
        }
        
    }
    
    
    func makeCategoryCellRegistration() -> UICollectionView.CellRegistration<CategoryCell, Product> {
        .init { cell, indexPath, category in
            cell.configure(with: category)
            cell.backgroundColor = .green
            
            
        }
    }
    
    
    func makeCreatorsCellRegistration() -> UICollectionView.CellRegistration<RatedRecipeCell, Creators> {
        .init { cell, indexPath, recipe in
            //        cell.configure(with: recipe)
            cell.backgroundColor = .cyan
        }
    }
    
    func makeHeaderRegistraition() -> UICollectionView.SupplementaryRegistration<TitleSupplementaryView> {
        .init(
            elementKind: UICollectionView.elementKindSectionHeader) { supplementaryView, elementKind, indexPath in
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







