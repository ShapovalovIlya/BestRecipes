//
//  SeeAllPresenter.swift
//  BestRecipes
//
//  Created by Илья Шаповалов on 17.09.2023.
//

import Foundation

protocol SeeAllPresenterProtocol: AnyObject {
    var sortion: Endpoint.Sortion { get }
    
    func viewDidLoad()
    func viewDidDisappear()
    func didSelectRecipe(at index: Int)
}

protocol SeeAllPresenterDelegate: AnyObject {
    func recipesDidLoad(_ recipes: [Recipe])
}

final class SeeAllPresenter: SeeAllPresenterProtocol {
    typealias RecipeRequest = (Endpoint) async throws -> [Recipe]
    
    //MARK: - Private properties
    private var recipes: [Recipe]
    private let recipeRequest: RecipeRequest
    private let router: HomeRouter
    
    //MARK: - Public properties
    weak var delegate: SeeAllPresenterDelegate?
    let sortion: Endpoint.Sortion
    
    //MARK: - init(_:)
    init(
        sortion: Endpoint.Sortion,
        recipes: [Recipe],
        router: HomeRouter,
        recipeRequest: @escaping RecipeRequest
    ) {
        self.sortion = sortion
        self.recipes = recipes
        self.router = router
        self.recipeRequest = recipeRequest
    }
    
    //MARK: - Public methods
    func viewDidLoad() {
        delegate?.recipesDidLoad(recipes)
        performRequest()
    }
    
    func viewDidDisappear() {
        
    }
    
    func didSelectRecipe(at index: Int) {
        router.showDetail(recipe: recipes[index])
    }
}

private extension SeeAllPresenter {
    func performRequest() {
        Task(priority: .userInitiated) {
            do {
                recipes = try await recipeRequest(.getRecipes(sortedBy: sortion))
                delegate?.recipesDidLoad(recipes)
            } catch {
                print(error)
            }
        }
    }
}
