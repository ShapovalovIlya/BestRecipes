//
//  DiscoverPresenter.swift
//  BestRecipes
//
//  Created by Леонид Турко on 15.09.2023.
//

import Foundation
import OSLog

protocol DiscoverPresenterProtocol: AnyObject {
  func viewDidLoad()
  func willDisplayCell(at index: Int)
  func viewDidDisapear()
  func didSelectRecipe(at index: Int)
}

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
  
  func viewDidLoad() {
    let recipeOne = Recipe(id: "Hello", title: "One", sourceName: nil, image: "Hello", summary: nil, extendedIngredients: nil, readyInMinutes: 5)
    let recipeTwo = Recipe(id: "Hello", title: "Two", sourceName: nil, image: "Hello", summary: nil, extendedIngredients: nil, readyInMinutes: 5)
    let recipeThree = Recipe(id: "Hello", title: "Three", sourceName: nil, image: "Hello", summary: nil, extendedIngredients: nil, readyInMinutes: 5)
    
    recipes = [recipeOne, recipeTwo, recipeThree]
    delegate?.recipesDidLoad([recipeOne, recipeTwo, recipeThree])
  }
  
  func willDisplayCell(at index: Int) {
    
  }
  
  func viewDidDisapear() {
    
  }
  
  func didSelectRecipe(at index: Int) {
    guard index <= recipes.count-1 else { return }
    router.showDetail(recipe: recipes[index])
  }
}
