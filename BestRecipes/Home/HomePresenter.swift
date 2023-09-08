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
}

//MARK: - HomePresenterDelegate
protocol HomePresenterDelegate: AnyObject {
    func recipesDidLoad(_ recipes: RecipesList)
}

final class HomePresenter: HomePresenterProtocol {
    //MARK: - Private properties
    private let router: HomeRouterProtocol
    private let apiClient: ApiClientProtocol
    
    //MARK: - Public properties
    weak var delegate: HomePresenterDelegate?
    
    //MARK: - init(_:)
    init(
        apiClient: ApiClientProtocol,
        router: HomeRouterProtocol
    ) {
        self.apiClient = apiClient
        self.router = router
        
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
    
    func detailButtonTap() {
//        router.showDetail(recipe: <#T##Recipe#>)
    }
}

private extension HomePresenter {
    //MARK: - Private methods
}
