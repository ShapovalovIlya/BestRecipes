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
    
    static let loadingView = LoadingView()
    
    func isLoading(_ isLoading: Bool) {
        Task {
            await MainActor.run {
                if isLoading {
                    addSubview(UIView.loadingView)
                    UIView.loadingView.frame = bounds
                } else {
                    UIView.loadingView.removeFromSuperview()
                }
            }
        }
    }
}
