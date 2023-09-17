//
//  FavoriteRecipesManager.swift
//  BestRecipes
//
//  Created by Илья Шаповалов on 17.09.2023.
//

import Foundation

final class FavoriteRecipesManager {
    static let shared = FavoriteRecipesManager()
    var recipes = Set<Recipe>()
    
    private init() {}
}
