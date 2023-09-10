//
//  Repository.swift
//  BestRecipes
//
//  Created by Илья Шаповалов on 09.09.2023.
//

import Foundation
import OSLog

struct Repository {
    private let apiClient: ApiClient
    private let cache: Cache<String, Decodable>
    
    //MARK: - init(_:)
    init() {
        apiClient = .init(session: .shared)
        cache = .init()
    }
    
    //MARK: - Public methods
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        if let value = cache.value(forKey: endpoint.url.absoluteString) {
            Logger.system.debug("Repository: load content of \(endpoint.url) from cache")
            guard let content = value as? T else {
                throw MachError(.failure)
            }
            return content
        } else {
            Logger.system.debug("Repository: load content of \(endpoint.url) from API")
            let content: T = try await apiClient.request(endpoint)
            cache.insert(content, forKey: endpoint.url.absoluteString)
            return content
        }
    }

}
