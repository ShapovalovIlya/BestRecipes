//
//  UIStackView+.swift
//  BestRecipes
//
//  Created by Илья Шаповалов on 08.09.2023.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach(addArrangedSubview(_:))
    }
}
