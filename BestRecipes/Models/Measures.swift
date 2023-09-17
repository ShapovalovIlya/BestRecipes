//
//  Measures.swift
//  BestRecipes
//
//  Created by Илья Шаповалов on 28.08.2023.
//

import Foundation

struct Measures: Decodable, Hashable {
    let metric: MetricMeasures
}

struct MetricMeasures: Decodable, Hashable {
    let amount: Double
    let unitShort: String
}
