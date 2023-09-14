//
//  RecipesList.swift
//  BestRecipes
//
//  Created by Илья Шаповалов on 31.08.2023.
//

import Foundation

struct RecipesList {
    var trending: [Recipe]
    var selectedCategory: MealType
    var categoryRecipes: [Recipe]
    var recent: [Recipe]
    
    //MARK: - init(_:)
    init(
        trending: [Recipe],
        selectedCategory: MealType,
        category: [Recipe],
        recent: [Recipe]
    ) {
        self.trending = trending
        self.selectedCategory = selectedCategory
        self.categoryRecipes = category
        self.recent = recent
    }
    
    init() {
        trending = .init()
        selectedCategory = .breakfast
        categoryRecipes = .init()
        recent = .init()
    }
    
    //MARK: - Sample
//    static let sample = Self(
//        trending: [.sample], 
//        selectedCategory: .breakfast,
//        category: [.sample],
//        recent:[.sample]
//    )
}
