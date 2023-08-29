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
    private var dataSource: UICollectionViewDiffableDataSource<Section, Recipe>?
    
    
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
        homeView.frame = self.view.bounds
        logger.debug("View loaded")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
        logger.debug("View did load")
        self.homeView.searchBar.delegate = self
        
        
       
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        presenter.viewDidDisappear()
    }
    
}

//MARK: - HomePresenterDelegate
extension HomeViewController: HomePresenterDelegate {
    func recipesDidLoad(_ recipes: [Recipe]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Recipe>()
        
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(recipes, toSection: .creators)
        snapshot.appendItems(recipes, toSection: .popular)
        snapshot.appendItems(recipes, toSection: .recent)
        snapshot.appendItems(recipes, toSection: .trending)
        
        dataSource?.apply(snapshot)
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

private extension HomeViewController {
    //MARK: - Section
    enum Section: Int, CaseIterable {
        case trending
        case popular
        case recent
        case creators
    }
    
    //MARK: - Private methods
    func maleDataSource() -> UICollectionViewDiffableDataSource<Section, Recipe> {
        .init(collectionView: homeView.collectionView) { collectionView, indexPath, recipe in
            collectionView.dequeueConfiguredReusableCell(
                using: self.makeCellRegistration(),
                for: indexPath,
                item: recipe)
        }
    }
    
    func makeCellRegistration() -> UICollectionView.CellRegistration<RatedRecipeCell, Recipe> {
        .init { cell, indexPath, recipe in
            cell.configure(with: recipe)
        }
    }
    


    
    
 
    
    
    
}



