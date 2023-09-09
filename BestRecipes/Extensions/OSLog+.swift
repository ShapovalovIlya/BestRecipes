//
//  OSLog+.swift
//  BestRecipes
//
//  Created by Илья Шаповалов on 06.09.2023.
//

import OSLog

extension Logger {
    private static let subsystem: String = Bundle.main.bundleIdentifier!
    static let viewCycle = Logger(subsystem: subsystem, category: "viewcycle")
    static let system = Logger(subsystem: subsystem, category: "system")
}
