//
//  BellRouter.swift
//  BestRecipes
//
//  Created by Максим Нурутдинов on 04.09.2023.
//

import UIKit

protocol BellRouterProtocol {
    var navigationController: UINavigationController { get }
}

final class BellRouter: BellRouterProtocol {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func setupInitial() {
        navigationController.tabBarItem = .init(title: nil, image: UIImage(systemName: "bell"), tag: 3)
    }
}
