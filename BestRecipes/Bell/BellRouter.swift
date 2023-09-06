//
//  BellRouter.swift
//  BestRecipes
//
//  Created by Максим Нурутдинов on 04.09.2023.
//

import UIKit

final class BellRouter {
    private let navigationController: UINavigationController
    private let apiClient: SponacularApiClientProtocol
    init(navigationController: UINavigationController, apiClient: SponacularApiClientProtocol) {
        self.navigationController = navigationController
        self.apiClient = apiClient
    }
    
    func setupInitial() {
        navigationController.tabBarItem = .init(title: nil, image: UIImage(systemName: "bell"), tag: 3)
    }
}
