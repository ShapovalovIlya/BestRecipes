//
//  FavoritesRouter.swift
//  BestRecipes
//
//  Created by Илья Шаповалов on 04.09.2023.
//

import UIKit

final class FavoritesRouter {
    //MARK: - Private properties
    private let navigationController: UINavigationController
    
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
