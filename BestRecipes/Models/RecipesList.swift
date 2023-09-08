//
//  RecipesList.swift
//  BestRecipes
//
//  Created by Илья Шаповалов on 31.08.2023.
//

import Foundation

struct RecipesList {
    var trending: [Recipe]
    var category: [Recipe]
    var recent: [Recipe]
    
    static let sample = Self(
        trending: [.sample],
        category: [.sample],
        recent:[.sample]
    )
}
