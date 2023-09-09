//
//  ApiClient.swift
//  BestRecipes
//
//  Created by Илья Шаповалов on 27.08.2023.
//

import Foundation

struct ApiClient {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    //MARK: - Public methods
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        var request = URLRequest(url: endpoint.url)
        request.httpMethod = endpoint.method.rawValue
        let (data, urlResponse) = try await session.data(for: request)
        try check(urlResponse)
        
        return try JSONDecoder().decode(T.self, from: data)
    }
    
}

private extension ApiClient {
    //MARK: - Private methods
    func check(_ urlResponse: URLResponse) throws {
        guard
            let httpResponse = urlResponse as? HTTPURLResponse,
            (200...299).contains(httpResponse.statusCode)
        else {
            throw URLError(.badServerResponse)
        }
    }
}
