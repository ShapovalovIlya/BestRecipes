//
//  HomeRouter.swift
//  BestRecipes
//
//  Created by Илья Шаповалов on 27.08.2023.
//

import UIKit

protocol HomeRouterProtocol {
    var navigationController: UINavigationController { get }
}

final class HomeRouter: HomeRouterProtocol {
    let navigationController: UINavigationController
    
    //MARK: - Private properties
    private let assembly: HomeAssembly
    private let recipeRequest: HomePresenter.RecipesRequest
    
    //MARK: - init(_:)
    init(
        navigationController: UINavigationController,
        assembly: HomeAssembly,
        recipeRequest: @escaping HomePresenter.RecipesRequest
    ) {
        self.navigationController = navigationController
        self.assembly = assembly
        self.recipeRequest = recipeRequest
    }
    
    //MARK: - Public methods
    func setupInitial() {
        let homeView = HomeView()
        let presenter = HomePresenter(
            router: self, 
            recipeRequest: recipeRequest
        )
        let homeViewController = HomeViewController(
            homeView: homeView,
            presenter: presenter
        )
        presenter.delegate = homeViewController
        
        navigationController.viewControllers = [homeViewController]
        navigationController.tabBarItem = .init(
            title: nil,
            image: UIImage(systemName: "house"),
            tag: 0
        )
    }
    
    func showDetail() {
        
    }
    
}
