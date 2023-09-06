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
    //MARK: - Private properties
    private let apiClient: ApiClientProtocol
    private let assembly: FavoritesAssembly
    
    //MARK: - Public properties
    let navigationController: UINavigationController
    
    //MARK: - init(_:)
    init(
        navigationController: UINavigationController,
        apiClient: ApiClientProtocol,
        assembly: FavoritesAssembly
    ) {
        self.navigationController = navigationController
        self.apiClient = apiClient
        self.assembly = assembly
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
