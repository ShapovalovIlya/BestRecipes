//
//  Assembly.swift
//  BestRecipes
//
//  Created by Илья Шаповалов on 06.09.2023.
//

import UIKit
import OSLog

protocol RootAssembly {
    func makeHomeRouter() -> HomeRouterProtocol
    func makeFavoritesRouter() -> FavoritesRouterProtocol
    func makeTabbar() -> TabBarController
}

protocol FavoritesAssembly {
    
}

protocol HomeAssembly {
    
}

protocol ProfileAssembly {
    
}

typealias AssemblyProtocol = RootAssembly & HomeAssembly & FavoritesAssembly & ProfileAssembly

final class Assembly: AssemblyProtocol {
    //MARK: - Private properties
    private let apiClient = ApiClient()
    
    //MARK: - init(_:)
    init() {
        Logger.system.debug("Assembly: \(#function)")
    }
    
    func makeHomeRouter() -> HomeRouterProtocol {
        let navigationController = UINavigationController()
        let router = HomeRouter(
            navigationController: navigationController,
            apiClient: apiClient,
            assembly: self
        )
        router.setupInitial()
        return router
    }
    
    func makeFavoritesRouter() -> FavoritesRouterProtocol {
        let navigationController = UINavigationController()
        let router = FavoritesRouter(
            navigationController: navigationController,
            apiClient: apiClient,
            assembly: self
        )
        router.setupInitial()
        return router
    }
    
    func makeTabbar() -> TabBarController {
        let tabbar = TabBarController()
        
        return tabbar
    }
    
}