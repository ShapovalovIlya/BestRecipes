//
//  Endpoint.swift
//  BestRecipes
//
//  Created by Илья Шаповалов on 27.08.2023.
//

import Foundation

struct Endpoint {
    //MARK: - Private properties
    private let path: String
    private var queryItems: [URLQueryItem]
    
    //MARK: - Public properties
    let method: HTTPMethod
    
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.spoonacular.com"
        components.path = path
        
        if queryItems.isEmpty {
            components.queryItems = [Secret.apiKeyItem]
        } else {
            var items = queryItems
            items.append(Secret.apiKeyItem)
            components.queryItems = items
        }
        
        guard let url = components.url else {
            preconditionFailure("Unable to create url from: \(components)")
        }
        return url
    }
    
    //MARK: - init(_:)
    private init(
        method: HTTPMethod,
        path: String,
        queryItems: [URLQueryItem] = .init()
    ) {
        self.method = method
        self.path = path
        self.queryItems = queryItems
    }
    
    //MARK: - Public methods
    static func getRecipeInfo(id: Int) -> Self {
        .init(
            method: .GET,
            path: "/recipes/\(id)/information",
            queryItems: [
                .init(name: "includeNutrition", value: false.description)
            ]
        )
    }
    
    static func getRecipes(
        sortedBy sortion: Sortion,
        number: Int = 20,
        offset: Int = 0
    ) -> Self {
        .init(
            method: .GET,
            path: "/recipes/complexSearch",
            queryItems: [
                .init(name: "sort", value: sortion.rawValue),
                .init(name: "number", value: number.description),
                .init(name: "offset", value: offset.description),
                .init(name: "fillIngredients", value: false.description),
                .init(name: "addRecipeInformation", value: false.description),
                .init(name: "addRecipeNutrition", value: false.description)
            ]
        )
    }
    
    static func getRecipes(
        ofType type: MealType,
        number: Int = 20,
        offset: Int = 0
    ) -> Self {
        .init(
            method: .GET,
            path: "/recipes/complexSearch",
            queryItems: [
                .init(name: "type", value: type.rawValue),
                .init(name: "number", value: number.description),
                .init(name: "offset", value: offset.description),
                .init(name: "fillIngredients", value: false.description),
                .init(name: "addRecipeInformation", value: false.description),
                .init(name: "addRecipeNutrition", value: false.description)
            ]
        )
    }
    
    static func getAutocomplete(_ text: String?) -> Self {
        .init(
            method: .GET, 
            path: "/recipes/autocomplete",
            queryItems: [
                .init(name: "number", value: "10"),
                .init(name: "query", value: text)
            ]
        )
    }
    
}

extension Endpoint {
    enum Sortion: String {
        case time
        case popularity
    }
    
    enum HTTPMethod: String {
        case GET
        case POST
    }
}
