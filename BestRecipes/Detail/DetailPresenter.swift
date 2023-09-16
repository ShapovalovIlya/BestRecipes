//
//  DetailPresenter.swift
//  BestRecipes
//
//  Created by Илья Шаповалов on 06.09.2023.
//

import Foundation
import OSLog

protocol DetailPresenterProtocol: AnyObject {
    func viewDidLoad()
    func viewDidDisappear()
}

protocol DetailPresenterDelegate: AnyObject {
    func recipeDidLoad(_ recipe: Recipe)
}

final class DetailPresenter: DetailPresenterProtocol {
    typealias RecipeRequest = (Endpoint) async throws -> Recipe
    //MARK: - Private properties
    private var recipe: Recipe
    private let recipeRequest: RecipeRequest
    
    //MARK: - Public properties
    weak var delegate: DetailPresenterDelegate?
    
    //MARK: - init(_:)
    init(
        recipe: Recipe,
        recipeRequest: @escaping RecipeRequest
    ) {
        self.recipe = recipe
        self.recipeRequest = recipeRequest
        
        Logger.system.debug("DetailPresenter: \(#function)")
    }
    
    deinit {
        Logger.system.debug("DetailPresenter: \(#function)")
    }
    
    //MARK: - Public methods
    func viewDidLoad() {
        Task {
            recipe = try await recipeRequest(.getRecipeInfo(id: recipe.id))
        }
        delegate?.recipeDidLoad(recipe)
    }
    
    func viewDidDisappear() {
        Logger.system.debug("DetailPresenter: \(#function)")
    }
}
