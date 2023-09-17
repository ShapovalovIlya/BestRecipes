//
//  FavoritesRouter.swift
//  BestRecipes
//
//  Created by Леонид Турко on 15.09.2023.
//

import UIKit

// MARK: - FavoritesRouterProtocol
protocol FavoritesRouterProtocol {
    var navigationController: UINavigationController { get }
    func showDetail(recipe: Recipe)
}

final class FavoritesRouter: FavoritesRouterProtocol {
    // MARK: Public Properties
    let navigationController: UINavigationController
    
    // MARK: Private Properties
    private let assembly: FavoritesAssembly
    
    // MARK: - init(_:)
    init(
        navigationController: UINavigationController,
        assembly: FavoritesAssembly
    ) {
        self.navigationController = navigationController
        self.assembly = assembly
    }
    
    // MARK: Public Methods
    func setupInitial() {
        let viewController = assembly.makeDiscoverViewController(router: self)
        navigationController.viewControllers = [viewController]
    }
    
    func showDetail(recipe: Recipe) {
        let detailViewController = assembly.makeDetailViewController(recipe: recipe)
        navigationController.pushViewController(detailViewController, animated: true)
    }
}
