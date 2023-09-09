//
//  HomeRouter.swift
//  BestRecipes
//
//  Created by Илья Шаповалов on 27.08.2023.
//

import UIKit

protocol HomeRouterProtocol {
    
}

final class HomeRouter: HomeRouterProtocol {
    //MARK: - Private properties
    private let navigationController: UINavigationController
    
    //MARK: - init(_:)
    init(
        navigationController: UINavigationController
    ) {
        self.navigationController = navigationController
    }
    
    //MARK: - Public methods
    func setupInitial() {
        let homeView = HomeView()
        let presenter = HomePresenter(
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
