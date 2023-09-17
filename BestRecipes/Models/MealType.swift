//
//  MealType.swift
//  BestRecipes
//
//  Created by Илья Шаповалов on 04.09.2023.
//

import Foundation

enum MealType: String, CaseIterable {
    case dessert
    case appetizer
    case salad
    case bread
    case breakfast
    case soup
    case beverage
    case sauce
    case fingerfood
    case snack
    
    var title: String {
        rawValue.capitalized
    }
}
