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
    func didTapShowAll(in section: HomeViewController.Section)
}

//MARK: - HomePresenterDelegate
protocol HomePresenterDelegate: AnyObject {
    func recipesDidLoad(_ recipes: RecipesList)
    func showLoading()
    func dismissLoading()
}

final class HomePresenter: HomePresenterProtocol {
    //MARK: - Private properties
    private let router: HomeRouterProtocol
    private let apiClient: ApiClientProtocol
    private var receiptList: RecipesList = .init()
    
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
    
    func didSelectReceipt(at indexPath: IndexPath) {
        let recipe: Recipe
        
        switch HomeViewController.Section(rawValue: indexPath.section) {
        case .trending: recipe = self.receiptList.trending[indexPath.item]
        case .category: recipe = self.receiptList.category[indexPath.item]
        case .recent: recipe = self.receiptList.recent[indexPath.item]
        case .none: return
        }
        
        router.showDetail(recipe: recipe)
    }
    
    func didTapShowAll(in section: HomeViewController.Section) {
        switch section {
        case .trending:
            break
            
        case .category: return
            
        case .recent:
            break
            
        }
    }
}

private extension HomePresenter {
    //MARK: - Private methods
}
