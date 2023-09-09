//
//  Repository.swift
//  BestRecipes
//
//  Created by Илья Шаповалов on 09.09.2023.
//

import Foundation

struct Repository {
    private let apiClient: ApiClient
    private let cache: Cache<String, Decodable>
    
    //MARK: - init(_:)
    init() {
        apiClient = .init(.shared)
        cache = .init()
    }
    
    //MARK: - Public methods
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        if let value = cache.value(forKey: endpoint.url.absoluteString) {
            guard let content = value as? T else {
                throw MachError(.failure)
            }
            return content
        } else {
            let content: T = try await apiClient.request(endpoint)
            cache.insert(content, forKey: endpoint.url.absoluteString)
            return content
        }
    }

}
