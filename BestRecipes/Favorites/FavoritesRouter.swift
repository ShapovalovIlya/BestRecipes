//
//  FavoritesRouter.swift
//  BestRecipes
//
//  Created by Илья Шаповалов on 04.09.2023.
//

import UIKit

protocol FavoritesRouterProtocol {
    var navigationController: UINavigationController { get }
}

final class FavoritesRouter: FavoritesRouterProtocol {
    let navigationController: UINavigationController
    
    //MARK: - Private properties
    
    //MARK: - init(_:)
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    //MARK: - Public methods
    func setupInitial() {
        
        navigationController.tabBarItem = .init(
            title: nil,
            image: UIImage(systemName: "bookmark"),
            tag: 1
        )
    }
    
}
