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
    func searchTextDidChange(_ text: String)
    func seeAllTrendingButtonTap()
    func seeAllRecentButtonTap()
    func seeAllCreatorsButtonTap()
}

//MARK: - HomePresenterDelegate
protocol HomePresenterDelegate: AnyObject {
    func recipesDidLoad(_ recipes: [Product])
}

final class HomePresenter: HomePresenterProtocol {
    //MARK: - Private properties
    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: HomePresenter.self)
    )
    private let router: HomeRouterProtocol
    private let apiClient: SponacularApiClientProtocol
    
    //MARK: - Public properties
    weak var delegate: HomePresenterDelegate?
    
    //MARK: - init(_:)
    init(
        apiClient: SponacularApiClientProtocol,
        router: HomeRouterProtocol
        
    ) {
        self.apiClient = apiClient
        self.router = router
        
        logger.debug("Initialized")
    }
    
    //MARK: - Deinit
    deinit {
        logger.debug("Deinitialized")
    }
    
    //MARK: - Public methods
    func viewDidLoad() {
        
    }
    
    func viewDidDisappear() {
        
    }
    
    func searchTextDidChange(_ text: String) {
        
    }
    
    func seeAllTrendingButtonTap() {
        
    }
    
    func seeAllRecentButtonTap() {
        
    }
    
    func seeAllCreatorsButtonTap() {
        
    }
    
}

private extension HomePresenter {
    //MARK: - Private methods
}
