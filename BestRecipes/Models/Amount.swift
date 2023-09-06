//
//  Amount.swift
//  BestRecipes
//
//  Created by Илья Шаповалов on 28.08.2023.
//

import Foundation

struct Amount: Decodable, Hashable {
    let unit: String
    let value: Double
    
    enum CodingKeys: String, CodingKey {
        case metric
        case unit
        case value
    }
    
    init(unit: String, value: Double) {
        self.unit = unit
        self.value = value
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let subContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .metric)
        self.unit = try subContainer.decode(String.self, forKey: .unit)
        self.value = try subContainer.decode(Double.self, forKey: .value)
    }
}
