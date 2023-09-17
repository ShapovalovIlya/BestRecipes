//
//  String+.swift
//  BestRecipes
//
//  Created by Илья Шаповалов on 17.09.2023.
//

import Foundation

extension String {
    var convertFromHTML: String? {
        guard
            let encoded = self.data(using: .utf8),
            let decoded = try? NSAttributedString(
                data: encoded,
                options: [
                    .documentType: NSAttributedString.DocumentType.html,
                    .characterEncoding: NSUTF8StringEncoding
                ],
                documentAttributes: nil
            )
        else {
            return nil
        }
        return decoded.string
    }
}
