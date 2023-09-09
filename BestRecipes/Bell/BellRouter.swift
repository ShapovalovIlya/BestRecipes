//
//  BellRouter.swift
//  BestRecipes
//
//  Created by Максим Нурутдинов on 04.09.2023.
//

import UIKit

final class BellRouter {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func setupInitial() {
        navigationController.tabBarItem = .init(title: nil, image: UIImage(systemName: "bell"), tag: 3)
    }
}
