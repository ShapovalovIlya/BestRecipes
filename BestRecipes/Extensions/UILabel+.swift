//
//  UILabel+.swift
//  BestRecipes
//
//  Created by Илья Шаповалов on 08.09.2023.
//

import UIKit

extension UILabel {
    static func makeLabel(
        font: UIFont?,
        color: UIColor?,
        numberOfLines: Int = 1
    ) -> UILabel {
        let label = UILabel()
        label.font = font
        label.textColor = color
        label.numberOfLines = numberOfLines
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}
