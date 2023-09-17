//
//  SeeAllViewController.swift
//  BestRecipes
//
//  Created by Илья Шаповалов on 17.09.2023.
//

import UIKit
import OSLog

final class SeeAllViewController: UIViewController {
    //MARK: - Private properties
    private let seeAllView: SeeAllViewProtocol
    private let presenter: SeeAllPresenterProtocol
    private lazy var dataSource: UICollectionViewDiffableDataSource<Int, Recipe> = makeDataSource()
    
    //MARK: - init(_:)
    init(
        seeAllView: SeeAllViewProtocol,
        presenter: SeeAllPresenterProtocol
    ) {
        self.seeAllView = seeAllView
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
        Logger.viewCycle.debug("SeeAllViewController: \(#function)")
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life cycle
    override func loadView() {
        self.view = seeAllView
        
        Logger.viewCycle.debug("SeeAllViewController: \(#function)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = presenter.sortion.title

        seeAllView.collectionView.dataSource = dataSource
        seeAllView.collectionView.delegate = self
        presenter.viewDidLoad()
        Logger.viewCycle.debug("SeeAllViewController: \(#function)")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        presenter.viewDidDisappear()
        Logger.viewCycle.debug("SeeAllViewController: \(#function)")
    }

}

//MARK: - UICollectionViewDelegate
extension SeeAllViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        presenter.didSelectRecipe(at: indexPath.item)
    }
}

extension SeeAllViewController: SeeAllPresenterDelegate {
    func recipesDidLoad(_ recipes: [Recipe]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Recipe>()
        snapshot.appendSections([0])
        snapshot.appendItems(recipes, toSection: 0)
        
        dataSource.apply(snapshot)
    }
}

private extension SeeAllViewController {
    //MARK: - Private methods
    func makeDataSource() -> UICollectionViewDiffableDataSource<Int, Recipe> {
        let recipeRegistration = makeRecipeCellRegistration()
        
        return .init(collectionView: seeAllView.collectionView) { collectionView, indexPath, item in
            collectionView.dequeueConfiguredReusableCell(
                using: recipeRegistration,
                for: indexPath,
                item: item)
        }
    }
    
    func makeRecipeCellRegistration() -> UICollectionView.CellRegistration<RecipeCell, Recipe> {
        .init { cell, indexPath, recipe in
            cell.configure(with: recipe)
        }
    }
}
