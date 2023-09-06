//
//  Recipe.swift
//  BestRecipes
//
//  Created by Илья Шаповалов on 27.08.2023.
//

import Foundation

struct Recipe: Hashable, Identifiable, Equatable {
    let title: String
    let rating: Double
    let isFavorite: Bool
    let imageURL: String
    let id: Int
    
    static let sample: [Product] = [
        .init(name: "itemOne", imageName: "sun.haze"),
        .init(name: "itemTwo", imageName: "sun.haze"),
        .init(name: "itemThree", imageName: "sun.haze"),
        .init(name: "itemFive", imageName: "sun.cloud"),
        .init(name: "itemFour", imageName: "sun.haze")
    ]
    
    
    /*
     static let sample: [Recipe] = [
         .init(title: "one", rating: 1.0, isFavorite: true, imageURL: "1", id: 1),
         .init(title: "two", rating: 1.0, isFavorite: true, imageURL: "1", id: 2),
         .init(title: "three", rating: 1.0, isFavorite: true, imageURL: "1", id: 3),
         .init(title: "four", rating: 1.0, isFavorite: true, imageURL: "1", id: 4),
         .init(title: "five", rating: 1.0, isFavorite: true, imageURL: "1", id: 5)
     ]
     */
    
}


