//
//  BellRouter.swift
//  BestRecipes
//
//  Created by Максим Нурутдинов on 04.09.2023.
//

import UIKit

final class BellRouter {
    //MARK: - Private properties
    private let apiClient: ApiClientProtocol
    
    //MARK: - Public properties
    let navigationController: UINavigationController
    
    //MARK: - init(_:)
    init(
        navigationController: UINavigationController,
        apiClient: ApiClientProtocol
    ) {
        self.navigationController = navigationController
        self.apiClient = apiClient
    }
    
    func setupInitial() {
        navigationController.tabBarItem = .init(title: nil, image: UIImage(systemName: "bell"), tag: 2)
    }
}
