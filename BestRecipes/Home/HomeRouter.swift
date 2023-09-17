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
    func showAll(recipes: [Recipe], sortion: Endpoint.Sortion)
}

final class HomeRouter: HomeRouterProtocol {
    let navigationController: UINavigationController
    
    //MARK: - Private properties
    private let assembly: HomeAssembly
    
    //MARK: - init(_:)
    init(
        navigationController: UINavigationController,
        assembly: HomeAssembly
    ) {
        self.navigationController = navigationController
        self.assembly = assembly
    }
    
    //MARK: - Public methods
    func setupInitial() {
        let viewController = assembly.makeHomeViewController(router: self)
        navigationController.viewControllers = [viewController]
    }
    
    func showDetail(recipe: Recipe) {
        let detailViewController = assembly.makeDetailViewController(recipe: recipe)
        navigationController.pushViewController(detailViewController, animated: true)
    }
    
    func showAll(recipes: [Recipe], sortion: Endpoint.Sortion) {
        let viewController = assembly.makeSeeAllViewController(
            router: self,
            recipes: recipes,
            sortion: sortion
        )
        navigationController.pushViewController(viewController, animated: true)
    }
    
}
