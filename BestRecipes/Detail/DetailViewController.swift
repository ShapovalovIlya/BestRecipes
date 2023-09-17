//
//  DetailViewController.swift
//  BestRecipes
//
//  Created by Леонид Турко on 30.08.2023.
//

import UIKit
import OSLog

final class DetailViewController: UIViewController {
    //MARK: - Private properties
    private let presenter: DetailPresenterProtocol
    private let detailView: DetailViewProtocol
    private lazy var dataSource = makeDataSource()
    
    // MARK: - init(_:)
    init(
        presenter: DetailPresenterProtocol,
        detailView: DetailViewProtocol
    ) {
        self.presenter = presenter
        self.detailView = detailView
        super.init(nibName: nil, bundle: nil)
        
        Logger.viewCycle.debug("DetailViewController: \(#function)")
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - deinit
    deinit {
        Logger.viewCycle.debug("DetailViewController: \(#function)")
    }
    
    //  MARK: - Life Cycle
    override func loadView() {
        self.view = detailView
        
        Logger.viewCycle.debug("DetailViewController: \(#function)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource.supplementaryViewProvider = makeHeaderRegistration().headerProvider
        detailView.collectionView.dataSource = dataSource
        
        presenter.viewDidLoad()
        
        Logger.viewCycle.debug("DetailViewController: \(#function)")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        presenter.viewDidDisappear()
        Logger.viewCycle.debug("DetailViewController: \(#function)")
    }
    
}

extension DetailViewController: DetailPresenterDelegate {
    func recipeDidLoad(_ recipe: Recipe) {
        detailView.titleLabel.text = recipe.title
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(
            [Item.title(recipe)],
            toSection: .title
        )
        snapshot.appendItems(
            [Item.summary(recipe.summary)],
            toSection: .summary
        )

        snapshot.appendItems(
            recipe.extendedIngredients?.map(Item.ingredient) ?? .init(),
            toSection: .ingredients
        )
     
        dataSource.apply(snapshot)
    }
}

extension DetailViewController {
    //MARK: - Section
    enum Section: Int, CaseIterable {
        case title
        case summary
        case ingredients
    }
    
    //MARK: - Item
    enum Item: Hashable {
        case title(Recipe)
        case summary(String?)
        case ingredient(Ingredient)
    }
    
}

private extension DetailViewController {
    //MARK: - Private methods
    func makeDataSource() -> UICollectionViewDiffableDataSource<Section, Item> {
        let ingredientRegistration = makeIngredientCellRegistration()
        let titleRegistration = makeTitleRegistration()
        let summaryRegistration = makeSummaryRegistration()
        
        return .init(collectionView: detailView.collectionView) { collectionView, indexPath, item in
            switch item {
            case let .title(recipe):
                return collectionView.dequeueConfiguredReusableCell(
                    using: titleRegistration,
                    for: indexPath,
                    item: recipe
                )
            case let .summary(text):
                return collectionView.dequeueConfiguredReusableCell(
                    using: summaryRegistration,
                    for: indexPath,
                    item: text
                )
                
            case let .ingredient(ingredient):
                return collectionView.dequeueConfiguredReusableCell(
                    using: ingredientRegistration,
                    for: indexPath,
                    item: ingredient
                )
            }
        }
    }
    
    func makeTitleRegistration() -> UICollectionView.CellRegistration<RecipeTitleCell, Recipe> {
        .init { cell, _, recipe in
            cell.configure(with: recipe)
        }
    }
    
    func makeSummaryRegistration() -> UICollectionView.CellRegistration<RecipeSummaryCell, String?> {
        .init { cell, _, summary in
            cell.configure(with: summary)
        }
    }
    
    func makeIngredientCellRegistration() -> UICollectionView.CellRegistration<IngredientCell, Ingredient> {
        .init { cell, _, ingredient in
            cell.configure(with: ingredient)
        }
    }
    
    func makeHeaderRegistration() -> UICollectionView.SupplementaryRegistration<HeaderView> {
        .init(elementKind: UICollectionView.elementKindSectionHeader) { header, elementKind, indexPath in
            let tutorialSection = ["How to cook", "Instructions", "Ingredients"]
            let title = tutorialSection[indexPath.section]
            
            switch Section(rawValue: indexPath.section) {
            case .title:
                header.configure(title: title)
                
            case .summary:
                header.configure(title: title)
                
            case .ingredients:
                header.configure(title: title)
                
            case nil:
                break
            }
        }
    }
    
}

extension UICollectionView.CellRegistration<UICollectionViewCell, DetailViewController.Item> {
    var cellProvider: (UICollectionView, IndexPath, Item) -> Cell {
        return { collectionView, indexPath, item in
            collectionView.dequeueConfiguredReusableCell(
                using: self,
                for: indexPath,
                item: item
            )
        }
    }
}
