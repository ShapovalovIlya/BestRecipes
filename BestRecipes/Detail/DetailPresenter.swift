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
        self.recipe = Self.removedDuplicateIngredients(from: recipe)
        self.recipeRequest = recipeRequest
        
        Logger.system.debug("DetailPresenter: \(#function)")
    }
    
    deinit {
        Logger.system.debug("DetailPresenter: \(#function)")
    }
    
    //MARK: - Public methods
    func viewDidLoad() {
        Task {
            do {
                let downloaded = try await recipeRequest(.getRecipeInfo(id: recipe.id))
                recipe = Self.removedDuplicateIngredients(from: downloaded)
                await MainActor.run {
                    delegate?.recipeDidLoad(recipe)
                }
            } catch {
                print(error)
            }
        }
    }
    
    func viewDidDisappear() {
        Logger.system.debug("DetailPresenter: \(#function)")
    }
    
    private static func removedDuplicateIngredients(from recipe: Recipe) -> Recipe {
        guard let ingredients = recipe.extendedIngredients else {
            return recipe
        }
        let unique = Set(ingredients)
        
        return .init(
            id: recipe.id,
            title: recipe.title,
            sourceName: recipe.sourceName,
            image: recipe.image,
            summary: recipe.summary,
            extendedIngredients: Array(unique),
            readyInMinutes: recipe.readyInMinutes,
            aggregateLikes: recipe.aggregateLikes
        )
    }
}
