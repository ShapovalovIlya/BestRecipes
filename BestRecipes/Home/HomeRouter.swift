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
            image: UIImage(systemName: "house"),
            tag: 0
        )
    }
    
    func showDetail() {
        
    }
    
}
