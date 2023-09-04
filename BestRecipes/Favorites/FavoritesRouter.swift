//
//  FavoritesRouter.swift
//  BestRecipes
//
//  Created by Илья Шаповалов on 04.09.2023.
//

import UIKit

final class ProfileRouter {
    //MARK: - Private properties
    private let navigationController: UINavigationController
    private let apiClient: SponacularApiClientProtocol
    
    //MARK: - init(_:)
    init(
        navigationController: UINavigationController,
        apiClient: SponacularApiClientProtocol
    ) {
        self.navigationController = navigationController
        self.apiClient = apiClient
    }
    
    func setupInitial() {
        
        navigationController.tabBarItem = .init(
            title: nil,
            image: UIImage(systemName: "person"),
            tag: 2
        )
    }
}

final class FavoritesRouter {
    //MARK: - Private properties
    private let navigationController: UINavigationController
    private let apiClient: SponacularApiClientProtocol
    
    //MARK: - init(_:)
    init(
        navigationController: UINavigationController,
        apiClient: SponacularApiClientProtocol
    ) {
        self.navigationController = navigationController
        self.apiClient = apiClient
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