//
//  extension.swift
//  CustomTabbar
//
//  Created by Максим Нурутдинов on 27.08.2023.
//

import UIKit

extension UIColor {
    static let tabBarButtonColor: UIColor? = .init(hex: "#fe989b", alpha: 1)
    static let tabBarTintColor: UIColor? = .init(hex: "#E23E3E", alpha: 1)
    static let getStartedButtonColor: UIColor? = .init(named: "onboardingColor")
    static let onboardingLabelAdditionalColor: UIColor? = .init(named: "onboardingLabelAdditional")
    
    public convenience init?(hex: String, alpha: Double = 1.0) {
        var pureString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if (pureString.hasPrefix("#")) {
            pureString.remove(at: pureString.startIndex)
        }
        if ((pureString.count) != 6) {
            return nil
        }
        let scanner = Scanner(string: pureString)
        var hexNumber: UInt64 = 0

        if scanner.scanHexInt64(&hexNumber) {
            self.init(
                red: CGFloat((hexNumber & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((hexNumber & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(hexNumber & 0x0000FF) / 255.0,
                alpha: CGFloat(1.0))
            return
        }
        return nil
    }
}

extension UIColor {
    
    static var customBorderColor: UIColor { UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha: 1) }
}


