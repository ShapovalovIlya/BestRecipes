//
//  UIButton+.swift
//  BestRecipes
//
//  Created by Илья Шаповалов on 09.09.2023.
//

import UIKit

extension UIButton {
    static func makeButtonBookmark() -> UIButton {
        let button = UIButton(type: .custom)
        button.setImage(.bookmarkImage, for: .normal)
        button.setImage(.bookmarkTabSelected, for: .selected)
        button.layer.masksToBounds = true
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}
