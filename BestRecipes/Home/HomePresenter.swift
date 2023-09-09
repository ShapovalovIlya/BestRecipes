//
//  HomePresenter.swift
//  BestRecipes
//
//  Created by Илья Шаповалов on 27.08.2023.
//

import Foundation
import OSLog

//MARK: - HomePresenterProtocol
protocol HomePresenterProtocol: AnyObject {
    func viewDidLoad()
    func viewDidDisappear()
    func didSelectReceipt(at indexPath: IndexPath)
}

//MARK: - HomePresenterDelegate
protocol HomePresenterDelegate: AnyObject {
    func recipesDidLoad(_ recipes: RecipesList)
    func showLoading()
    func dismissLoading()
}

final class HomePresenter: HomePresenterProtocol {
    typealias RecipesRequest = (Endpoint) async throws -> RecipeResponse
    
    //MARK: - Private properties
    private let router: HomeRouterProtocol
    private let recipeRequest: RecipesRequest
    
    //MARK: - Public properties
    weak var delegate: HomePresenterDelegate?
    
    //MARK: - init(_:)
    init(
        router: HomeRouterProtocol,
        recipeRequest: @escaping RecipesRequest
    ) {
        self.router = router
        self.recipeRequest = recipeRequest
        
        Logger.system.debug("HomePresenter: \(#function)")
    }
    
    //MARK: - Deinit
    deinit {
        Logger.system.debug("HomePresenter: \(#function)")
    }
    
    //MARK: - Public methods
    func viewDidLoad() {
        
    }
    
    func viewDidDisappear() {
        
    }
    
    func didSelectReceipt(at indexPath: IndexPath) {
        
    }
    
    
}

private extension HomePresenter {
    //MARK: - Private methods
}
