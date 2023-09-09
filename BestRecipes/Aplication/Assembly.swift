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
    func makeBellRouter() -> BellRouter
    func makeProfileRouter() -> ProfileRouterProtocol
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
    private let repository: Repository
    
    //MARK: - init(_:)
    init() {
        repository = .init()
        Logger.system.debug("Assembly: \(#function)")
    }
    
    func makeHomeRouter() -> HomeRouterProtocol {
        let navigationController = UINavigationController()
        let router = HomeRouter(
            navigationController: navigationController, 
            assembly: self,
            recipeRequest: repository.request
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
    
    func makeBellRouter() -> BellRouter {
        let navigationController = UINavigationController()
        let router = BellRouter(
            navigationController: navigationController,
            apiClient: apiClient
        )
        router.setupInitial()
        return router
    }
    
    func makeProfileRouter() -> ProfileRouterProtocol {
        let navigationController = UINavigationController()
        let router = ProfileRouter(
            navigationController: navigationController,
            apiClient: apiClient,
            assembly: self
        )
        router.setupInitial()
        return router
    }
    
}
