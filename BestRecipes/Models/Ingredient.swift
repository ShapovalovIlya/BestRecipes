//
//  Ingredient.swift
//  BestRecipes
//
//  Created by Илья Шаповалов on 28.08.2023.
//

import Foundation

/// Модель ингредиента
struct Ingredient: Decodable, Hashable {
    let id: Int
    /// Название ингредиента
    let name: String
    
    /// Имя картинки ингредиента
    let image: String
    
    /// Количество
    let amount: Double
    
    let measures: Measures
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
    }
}

extension Ingredient {
    static let sample: [Ingredient] = [
        .init(id: 0, name: "Fish", image: "Fish", amount: 1, measures: .init(metric: .init(amount: 1, unitShort: "g"))),
        .init(id: 1, name: "Sugar", image: "Sugar", amount: 1, measures: .init(metric: .init(amount: 1, unitShort: "g"))),
        .init(id: 2, name: "Ginger", image: "Ginger", amount: 1, measures: .init(metric: .init(amount: 1, unitShort: "g"))),
        .init(id: 3, name: "Salt", image: "Salt", amount: 1, measures: .init(metric: .init(amount: 1, unitShort: "g")))
    ]
}
