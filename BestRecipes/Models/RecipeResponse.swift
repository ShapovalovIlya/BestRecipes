//
//  RecipeResponse.swift
//  BestRecipes
//
//  Created by Илья Шаповалов on 04.09.2023.
//

import Foundation

struct RecipeResponse: Decodable {
    let offset: Int
    let number: Int
    let results: [Recipe]
    let totalResults: Int
    
    static let sample = Self(
        offset: 0,
        number: 1,
        results: [.sample],
        totalResults: 1
    )
}
