//
//  Category.swift
//  BestRecipes
//
//  Created by Эльдар Ахатов on 03/09/23.
//

import Foundation


struct Category: Equatable, Hashable {

    let title: String
    let rating: Double
    let isFavorite: Bool
    let imageURL: String
    let id: Int
    
    
    
    static let sample: [Product] = [
        .init(name: "1", imageName: "sun.haze"),
        .init(name: "2", imageName: "sun.haze"),
        .init(name: "3", imageName: "sun.haze"),
        .init(name: "4", imageName: "sun.cloud"),
        .init(name: "5", imageName: "sun.haze")
    ]
    
    
    
    
    
    /*
     
     static let sample: [Category] = [
         .init(title: "one", rating: 1.0, isFavorite: true, imageURL: "1", id: 1),
         .init(title: "two", rating: 1.0, isFavorite: true, imageURL: "1", id: 2),
         .init(title: "three", rating: 1.0, isFavorite: true, imageURL: "1", id: 3),
         .init(title: "four", rating: 1.0, isFavorite: true, imageURL: "1", id: 4),
         .init(title: "five", rating: 1.0, isFavorite: true, imageURL: "1", id: 5)
     ]
     
     */
}


