//
//  Ingredient.swift
//  BestRecipes
//
//  Created by Илья Шаповалов on 28.08.2023.
//

import Foundation

/// Модель ингредиента
struct Ingredient: Decodable, Hashable {
    /// Название ингредиента
    let name: String
    
    /// Имя картинки ингредиента
    let image: String
    
    /// Количество
    let amount: Amount
}
