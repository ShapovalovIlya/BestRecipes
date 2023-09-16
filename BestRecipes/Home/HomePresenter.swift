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
                self.recipeList = try await getRecipeList(category: recipeList.selectedCategory)
                self.delegate?.recipesDidLoad(recipeList)
            } catch {
                self.delegate?.dismissLoading()
            }
        }
    }
    
    func viewDidDisappear() {
        
    }
    
    func didSelectReceipt(at indexPath: IndexPath) {
        let recipe: Recipe
        
        switch HomeViewController.Section(rawValue: indexPath.section) {
        case .trending:
            recipe = recipeList.trending[indexPath.item]
            
        case .category:
            recipe = recipeList.categoryRecipes[indexPath.item]
            
        case .recent:
            recipe = recipeList.recent[indexPath.item]
            
        case .none: return
        }
        
        router.showDetail(recipe: recipe)
    }
    
    
}

private extension HomePresenter {
    enum Section {
        case trending([Recipe])
        case category([Recipe])
        case recent([Recipe])
    }
    
    //MARK: - Private methods
    func getRecipeList(category: MealType) async throws -> RecipesList {
        try await withThrowingTaskGroup(
            of: Section.self,
            returning: RecipesList.self
        ) { [weak self] group in
            guard let self else {
                return .init()
            }
            
            group.addTask {
                try await Section.trending(self.recipeRequest(.getRecipes(sortedBy: .popularity)).results)
            }
            group.addTask {
                try await Section.category(self.recipeRequest(.getRecipes(ofType: category)).results)
            }
            group.addTask {
                try await Section.recent(self.recipeRequest(.getRecipes(sortedBy: .time)).results)
            }
            
            return try await group.reduce(into: RecipesList(), recipeSortion)
        }
    }
    
    func recipeSortion(result: inout RecipesList, response: Section) {
        switch response {
        case let .trending(recipes):
            result.trending = recipes
            
        case let .category(recipes):
            result.categoryRecipes = recipes
            
        case let .recent(recipes):
            result.recent = recipes
        }
    }
}
