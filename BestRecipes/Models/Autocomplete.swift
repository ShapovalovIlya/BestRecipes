//
//  Autocomplete.swift
//  BestRecipes
//
//  Created by Илья Шаповалов on 28.08.2023.
//

import Foundation

/// Autocomplete a partial input to suggest possible recipe names.
struct Autocomplete: Decodable {
    let id: Int
    let title: String
    let imageType: String
}
