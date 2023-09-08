//
//  ApiClient.swift
//  BestRecipes
//
//  Created by Илья Шаповалов on 27.08.2023.
//

import Foundation

protocol ApiClientProtocol {
    func getTrendingRecipes(number: Int, offset: Int) async throws -> RecipeResponse
    func getRecipes(by type: MealType, number: Int, offset: Int) async throws -> RecipeResponse
    func getAutocomplete(for text: String) async throws -> [AutocompleteResponse]
    func getRecipeInfo(withId id: String) async throws -> DetailRecipeResponse
}

final class ApiClient: ApiClientProtocol {
    
    func getTrendingRecipes(number: Int = 20, offset: Int = 0) async throws -> RecipeResponse {
        let trendingRecipeEndpoint = Endpoint.getRecipes(
            sortedBy: .popularity,
            number: number,
            offset: offset
        )
        let request = URLRequest(url: trendingRecipeEndpoint.url)
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard
            let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode >= 200,
            httpResponse.statusCode < 300
        else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode(RecipeResponse.self, from: data)
    }
    
    func getRecipes(by type: MealType, number: Int = 20, offset: Int = 0) async throws -> RecipeResponse {
        let trendingRecipeEndpoint = Endpoint.getRecipes(
            ofType: type,
            number: number,
            offset: offset
        )
        let request = URLRequest(url: trendingRecipeEndpoint.url)
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard
            let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode >= 200,
            httpResponse.statusCode < 300
        else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode(RecipeResponse.self, from: data)
    }
    
    func getAutocomplete(for text: String) async throws -> [AutocompleteResponse] {
        let endpoint = Endpoint.getAutocomplete(text)
        let request = URLRequest(url: endpoint.url)
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard
            let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode >= 200,
            httpResponse.statusCode < 300
        else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode([AutocompleteResponse].self, from: data)
    }
    
    func getRecipeInfo(withId id: String) async throws -> DetailRecipeResponse {
        let endpoint = Endpoint.getRecipeInfo(id: id)
        let request = URLRequest(url: endpoint.url)
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard
            let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode >= 200,
            httpResponse.statusCode < 300
        else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode(DetailRecipeResponse.self, from: data)
    }
}
