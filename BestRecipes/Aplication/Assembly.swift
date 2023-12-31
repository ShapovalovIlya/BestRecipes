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
  func makeDiscoverViewController(router: FavoritesRouterProtocol) -> DiscoverViewController
  func makeDetailViewController(recipe: Recipe) -> DetailViewController
}

protocol HomeAssembly {
    func makeHomeViewController(router: HomeRouterProtocol) -> HomeViewController
    func makeDetailViewController(recipe: Recipe) -> DetailViewController
    func makeSeeAllViewController(router: HomeRouter, recipes: [Recipe], sortion: Endpoint.Sortion) -> SeeAllViewController
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
    
    //MARK: - Home module
    func makeHomeRouter() -> HomeRouterProtocol {
        let navigationController = UINavigationController()
        navigationController.tabBarItem = .init(title: nil, image: .homeTab, tag: 0)
        navigationController.tabBarItem.selectedImage = .homeTabSelected
        let router = HomeRouter(
            navigationController: navigationController, 
            assembly: self
        )
        router.setupInitial()
        return router
    }
    
    func makeHomeViewController(router: HomeRouterProtocol) -> HomeViewController {
        let presenter = HomePresenter(
            router: router,
            recipeRequest: repository.request
        )
        let view = HomeView()
        let viewController = HomeViewController(
            homeView: view,
            presenter: presenter
        )
        presenter.delegate = viewController
        
        return viewController
    }
    
    func makeSeeAllViewController(
        router: HomeRouter,
        recipes: [Recipe],
        sortion: Endpoint.Sortion
    ) -> SeeAllViewController {
        let presenter = SeeAllPresenter(
            sortion: sortion,
            recipes: recipes,
            router: router,
            recipeRequest: repository.request
        )
        let view = SeeAllView()
        let viewController = SeeAllViewController(
            seeAllView: view, 
            presenter: presenter
        )
        presenter.delegate = viewController
        return viewController
    }
    
    //MARK: - Favorite module
  func makeDiscoverViewController(router: FavoritesRouterProtocol) -> DiscoverViewController {
    let presenter = DiscoverPresenter(
      router: router,
      recipeRequest: { Array(FavoriteRecipesManager.shared.recipes) }
    )
    let view = DiscoverView()
    let viewController = DiscoverViewController(
      discoverView: view,
      presenter: presenter
    )
    presenter.delegate = viewController
    return viewController
  }
 
   
  func makeFavoritesRouter() -> FavoritesRouterProtocol {
    let navigationController = UINavigationController()
    navigationController.tabBarItem = .init(title: nil, image: .bookmarkImage, tag: 1)
    navigationController.tabBarItem.selectedImage = .bookmarkSelected
    let router = FavoritesRouter(
      navigationController: navigationController,
      assembly: self
    )
    router.setupInitial()
    return router
  }
  
    
    func makeTabbar() -> TabBarController {
        let tabbar = TabBarController()
        
        return tabbar
    }
    
    //MARK: - Bell module
    func makeBellRouter() -> BellRouter {
        let navigationController = UINavigationController()
        navigationController.tabBarItem = .init(title: nil, image: .bellTab, tag: 2)
        let router = BellRouter(
            navigationController: navigationController,
            assembly: self
        )
        router.setupInitial()
        return router
    }
    
    //MARK: - Profile module
    func makeProfileRouter() -> ProfileRouterProtocol {
        let navigationController = UINavigationController()
        navigationController.tabBarItem = .init(title: nil, image: .profileTab, tag: 3)
        navigationController.tabBarItem.selectedImage = .profileTabSelected
        let router = ProfileRouter(
            navigationController: navigationController,
            assembly: self
        )
        router.setupInitial()
        return router
    }
    
    //MARK: - Detail module
    func makeDetailViewController(recipe: Recipe) -> DetailViewController {
        let presenter = DetailPresenter(
            recipe: recipe,
            recipeRequest: repository.request
        )
        let view = DetailView()
        let viewController = DetailViewController(
            presenter: presenter,
            detailView: view
        )
        presenter.delegate = viewController
        return viewController
    }
}
