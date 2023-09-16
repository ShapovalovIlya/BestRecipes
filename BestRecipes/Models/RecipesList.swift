//
//  RecipesList.swift
//  BestRecipes
//
//  Created by Илья Шаповалов on 31.08.2023.
//

import Foundation

struct RecipesList {
    var trending: [Recipe]
    var categoryRecipes: [Recipe]
    var recent: [Recipe]
    
    //MARK: - init(_:)
    init(
        trending: [Recipe],
        category: [Recipe],
        recent: [Recipe]
    ) {
        self.trending = trending
        self.categoryRecipes = category
        self.recent = recent
    }
    
    init() {
        trending = .init()
        categoryRecipes = .init()
        recent = .init()
    }
    
    //MARK: - Sample
    static let sample = Self(
        trending: [.sample], 
        category: [.sample],
        recent:[.sample]
    )
}
