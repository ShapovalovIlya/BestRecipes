//
//  Endpoint.swift
//  BestRecipes
//
//  Created by Илья Шаповалов on 27.08.2023.
//

import Foundation

struct Endpoint {
    let path: String
    var queryItems: [URLQueryItem] = .init()
    
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
    
    
    /// Эндпоинт для GET запросов. Возвращает подробную информацию о рецепте.
    /// - Parameter id: Уникальный id рецепта (`Recipe`)
    /// - Returns: запрос возвращает модель `Recipe`
    static func getRecipeInfo(id: String) -> Self {
        .init(path: "/recipe/\(id)/information")
    }
    
    /// Эндпоинт для GET запросов. Возвращает массив из 20 популярных рецептов.
    /// - Returns: запрос возвращает модель `[Recipe]`
    static let getPopularRecipes = Self(
        path: "/recipes",
        queryItems: [
            .init(name: "sort", value: "popularity"),
            .init(name: "number", value: "20")
        ]
    )
    
    /// Эндпоинт для GET запросов. Возвращает массив из 20 недавних рецептов.
    /// - Returns: запрос возвращает модель `[Recipe]`
    static let getRecentRecipes = Self(
        path: "/recipes",
        queryItems: [
            .init(name: "sort", value: "time"),
            .init(name: "number", value: "20")
        ]
    )
    
    /// Эндпоинт для GET запросов. Возвращает массив из 10 автокомплитов для поисковой строки.
    /// - Parameter text: Текст поисковой строки.
    /// - Returns: запрос возвращает модель
    static func getAutocomplete(_ text: String?) -> Self {
        .init(
            path: "/recipes/autocomplete",
            queryItems: [
                .init(name: "number", value: "10"),
                .init(name: "query", value: text)
            ]
        )
    }
}
