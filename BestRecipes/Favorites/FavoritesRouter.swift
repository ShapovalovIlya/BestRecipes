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
    private let assembly: FavoritesAssembly
    
    //MARK: - init(_:)
    init(
        navigationController: UINavigationController,
        assembly: FavoritesAssembly
    ) {
        self.navigationController = navigationController
        self.assembly = assembly
    }
    
    //MARK: - Public methods
    func setupInitial() {
        
        
    }
    
}
