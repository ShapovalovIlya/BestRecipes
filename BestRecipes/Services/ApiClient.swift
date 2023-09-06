//
//  ApiClient.swift
//  BestRecipes
//
//  Created by Илья Шаповалов on 27.08.2023.
//

import Foundation

protocol ApiClientProtocol {
    func getTrendingRecipes(number: Int, offset: Int) async throws -> RecipeResponse
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
}
