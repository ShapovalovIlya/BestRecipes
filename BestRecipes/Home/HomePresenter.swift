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
    private var recipeList = RecipesList()
    
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
        self.delegate?.showLoading()
        Task {
            do {
                self.recipeList = try await getRecipeList()
                self.delegate?.recipesDidLoad(recipeList)
            } catch {
                self.delegate?.dismissLoading()
            }
        }
    }
    
    func viewDidDisappear() {
        
    }
    
    func didSelectReceipt(at indexPath: IndexPath) {
        
    }
    
    
}

private extension HomePresenter {
    //MARK: - Private methods
    func getRecipeList() async throws -> RecipesList {
        try await withThrowingTaskGroup(
            of: RecipeResponse.self,
            returning: RecipesList.self
        ) { group in
            let trendingRecipes = try await recipeRequest(.getRecipes(sortedBy: .popularity))
            let categoryRecipes = try await recipeRequest(.getRecipes(ofType: .breakfast))
            let recentRecipes = try await recipeRequest(.getRecipes(sortedBy: .time))
            
            return try await group.reduce(into: RecipesList()) { partialResult, response in
                partialResult.trending = trendingRecipes.results
                partialResult.categoryRecipes = categoryRecipes.results
                partialResult.recent = recentRecipes.results
            }
        }
    }
}
