//
//  UIView.swift
//  BestRecipes
//
//  Created by Илья Шаповалов on 06.09.2023.
//

import UIKit

extension UIView {
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach(addSubview)
    }
}
