//
//  HomeRouter.swift
//  BestRecipes
//
//  Created by Илья Шаповалов on 27.08.2023.
//

import UIKit

protocol HomeRouterProtocol {
    func showDetail(recipe: Recipe)
}

final class HomeRouter: HomeRouterProtocol {
    private let navigationController: UINavigationController
    private let apiClient: SponacularApiClientProtocol
    
    init(
        navigationController: UINavigationController,
        apiClient: SponacularApiClientProtocol
    ) {
        self.navigationController = navigationController
        self.apiClient = apiClient
    }
    
    func initialView() {
        let homeView = HomeView()
        let homePresenter = HomePresenter(
            apiClient: apiClient,
            router: self
        )
        let homeViewController = HomeViewController(
            homeView: homeView,
            presenter: homePresenter
        )
        homePresenter.delegate = homeViewController
        
        self.navigationController.viewControllers = [homeViewController]
        self.navigationController.tabBarItem = .init(
            title: nil,
            image: UIImage(systemName: "house"),
            tag: 0
        )
    }
    
    func showDetail(recipe: Recipe) {
        let detailViewController = UIViewController()
        
        self.navigationController.present(detailViewController, animated: true)
    }
}
