//
//  ProfileRouter.swift
//  BestRecipes
//
//  Created by Максим Нурутдинов on 04.09.2023.
//

import UIKit

protocol ProfileRouterProtocol: AnyObject {
    var navigationController: UINavigationController { get }
}

final class ProfileRouter: ProfileRouterProtocol {
    //MARK: - Private properties
    private let apiClient: ApiClient
    private let assembly: ProfileAssembly
    
    //MARK: - Public properties
    let navigationController: UINavigationController
    
    //MARK: - init(_:)
    init(
        navigationController: UINavigationController,
        apiClient: ApiClient,
        assembly: ProfileAssembly
    ) {
        self.navigationController = navigationController
        self.apiClient = apiClient
        self.assembly = assembly
    }
    
    //MARK: - Public methods
    func setupInitial() {
        let profileViewController = ProfileViewController()
        navigationController.viewControllers = [profileViewController]
        navigationController.tabBarItem = .init(
            title: nil,
            image: .profileTab,
            tag: 3
        )
        navigationController.tabBarItem.selectedImage = .profileTabSelected
    }
}
