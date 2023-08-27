//
//  SponacularEndpoint.swift
//  BestRecipes
//
//  Created by Илья Шаповалов on 27.08.2023.
//

import Foundation

private struct Constants {
    static let apiKey: String = "317592d32b1e4346ba205b6abdd25330"
}

struct SponacularEndpoint {
    let path: String
    var queryItems: [URLQueryItem] = .init()
    
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.spoonacular.com"
        components.path = path
        
        if !queryItems.isEmpty {
            components.queryItems = queryItems
        }
        
        guard let url = components.url else {
            preconditionFailure("Unable to create url from: \(components)")
        }
        return url
    }
    
    static func getRecipeInfo(id: String) -> Self {
        .init(path: "recipe/\(id)/information?apiKey=\(Constants.apiKey)")
    }
}
