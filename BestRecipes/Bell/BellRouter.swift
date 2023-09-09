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
    
    //MARK: - Private methods
    private let assembly: Assembly
    
    //MARK: - init(_:)
    init(
        navigationController: UINavigationController,
        assembly: Assembly
    ) {
        self.navigationController = navigationController
        self.assembly = assembly
    }
    
    //MARK: - Public methods
    func setupInitial() {
        
    }
}
