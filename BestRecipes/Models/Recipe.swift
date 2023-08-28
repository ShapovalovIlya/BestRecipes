//
//  Recipe.swift
//  BestRecipes
//
//  Created by Илья Шаповалов on 27.08.2023.
//

import Foundation

struct Recipe: Hashable {
    let title: String
    let rating: Double
    let isFavorite: Bool
    let imageURL: String
}
