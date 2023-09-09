//
//  ApiClient.swift
//  BestRecipes
//
//  Created by Илья Шаповалов on 27.08.2023.
//

import Foundation

struct ApiClient {
    //MARK: - Public methods
    func getTrendingRecipes(
        number: Int = 20,
        offset: Int = 0
    ) async throws -> RecipeResponse {
        let endpoint = Endpoint.getRecipes(
            sortedBy: .popularity,
            number: number,
            offset: offset
        )
        let request = URLRequest(url: endpoint.url)
        let (data, urlResponse) = try await URLSession.shared.data(for: request)
        try check(urlResponse)
        
        return try JSONDecoder().decode(RecipeResponse.self, from: data)
    }
    
    func getRecipes(
        by type: MealType,
        number: Int = 20,
        offset: Int = 0
    ) async throws -> RecipeResponse {
        let endpoint = Endpoint.getRecipes(
            ofType: type,
            number: number,
            offset: offset
        )
        let request = URLRequest(url: endpoint.url)
        let (data, urlResponse) = try await URLSession.shared.data(for: request)
        try check(urlResponse)
        
        return try JSONDecoder().decode(RecipeResponse.self, from: data)
    }
    
    func getAutocomplete(
        for text: String
    ) async throws -> [Autocomplete] {
        let endpoint = Endpoint.getAutocomplete(text)
        let request = URLRequest(url: endpoint.url)
        let (data, urlResponse) = try await URLSession.shared.data(for: request)
        try check(urlResponse)
        
        return try JSONDecoder().decode([Autocomplete].self, from: data)
    }
    
    func getRecipeInfo(
        withId id: String
    ) async throws -> Recipe {
        let endpoint = Endpoint.getRecipeInfo(id: id)
        let request = URLRequest(url: endpoint.url)
        let (data, urlResponse) = try await URLSession.shared.data(for: request)
        try check(urlResponse)
        
        return try JSONDecoder().decode(Recipe.self, from: data)
    }
}

private extension ApiClient {
    //MARK: - Private methods
    func check(_ urlResponse: URLResponse) throws {
        guard
            let httpResponse = urlResponse as? HTTPURLResponse,
            (200...300).contains(httpResponse.statusCode)
        else {
            throw URLError(.badServerResponse)
        }
    }
}
