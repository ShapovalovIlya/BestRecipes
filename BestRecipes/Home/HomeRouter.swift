//
//  HomeRouter.swift
//  BestRecipes
//
//  Created by Илья Шаповалов on 27.08.2023.
//

import UIKit

protocol HomeRouterProtocol {
    var navigationController: UINavigationController { get }
    
    func showDetail(recipe: Recipe)
    func showAllTrending(recipes: [Recipe])
    func showAllRecent(recipes: [Recipe])
}

final class HomeRouter: HomeRouterProtocol {
    //MARK: - Private properties
    private let apiClient: ApiClientProtocol
    private let assembly: HomeAssembly
    
    //MARK: - Public
    let navigationController: UINavigationController
    
    //MARK: - init(_:)
    init(
        navigationController: UINavigationController,
        apiClient: ApiClientProtocol,
        assembly: HomeAssembly
    ) {
        self.navigationController = navigationController
        self.apiClient = apiClient
        self.assembly = assembly
    }
    
    //MARK: - Public methods
    func setupInitial() {
        let homeView = HomeView()
        let presenter = HomePresenter(
            apiClient: apiClient,
            router: self
        )
        let homeViewController = HomeViewController(
            homeView: homeView,
            presenter: presenter
        )
        presenter.delegate = homeViewController
        
        navigationController.viewControllers = [homeViewController]
        navigationController.tabBarItem = .init(
            title: nil,
            image: .homeTab,
            tag: 0
        )
        navigationController.tabBarItem.selectedImage = .homeTabSelected
    }
    
    func showDetail(recipe: Recipe) {
        
    }
    
    func showAllTrending(recipes: [Recipe] = []) {
        
    }
    
    func showAllRecent(recipes: [Recipe] = []) {
        
    }
    
}
