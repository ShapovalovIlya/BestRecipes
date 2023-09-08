//
//  AutocopleteResponse.swift
//  BestRecipes
//
//  Created by Дарья Сотникова on 07.09.2023.
//

import Foundation

enum ImageType: String, Decodable {
    case jpg, jpeg
}

struct AutocompleteResponse: Decodable {
    let id: Int
    let title: String
    let imageType: ImageType
}

