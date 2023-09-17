//
//  DiscoverPresenter.swift
//  BestRecipes
//
//  Created by Леонид Турко on 15.09.2023.
//

import Foundation
import OSLog

// MARK: - DiscoverPresenterProtocol
protocol DiscoverPresenterProtocol: AnyObject {
    func viewWillAppear()
    func willDisplayCell(at index: Int)
    func viewDidDisappear()
    func didSelectRecipe(at index: Int)
}

// MARK: - DiscoverPresenterDelegate
protocol DiscoverPresenterDelegate: AnyObject {
    func recipesDidLoad(_ recipes: [Recipe])
}

final class DiscoverPresenter: DiscoverPresenterProtocol {
    typealias Favorites = () -> [Recipe]
    
    //MARK: - Private properties
    private let router: FavoritesRouterProtocol
    private let recipeRequest: Favorites
    private var recipes: [Recipe] = []
    
    //MARK: - Public properties
    weak var delegate: DiscoverPresenterDelegate?
    
    //MARK: - init(_:)
    init(
        router: FavoritesRouterProtocol,
        recipeRequest: @escaping Favorites
    ) {
        self.router = router
        self.recipeRequest = recipeRequest
    }
    
    // MARK: - Public methods
    func viewWillAppear() {
        recipes = recipeRequest()
        delegate?.recipesDidLoad(recipes)
    }
    
    func willDisplayCell(at index: Int) {
        
    }
    
    func viewDidDisappear() {
        
    }
    
    func didSelectRecipe(at index: Int) {
        guard index < recipes.count else { return }
        router.showDetail(recipe: recipes[index])
    }
}
