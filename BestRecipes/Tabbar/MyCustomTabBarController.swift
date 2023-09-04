//
//  MyCustomTabBarController.swift
//  BestRecipes
//
//  Created by Максим Нурутдинов on 04.09.2023.
//

import UIKit

final class MyCustomTabBarController: UITabBarController {
    private let btnMiddle: UIButton = makeButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCustomTabBar()
        configureMiddleButton()
    }
    
    func navigationControllers(_ controllers: UIViewController...) {
        self.viewControllers = controllers
    }
}

private extension MyCustomTabBarController {
    
    func setupCustomTabBar() {
        let path: UIBezierPath = getPathForTabBar()
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.lineWidth = 10
        shape.strokeColor = UIColor.white.cgColor
        shape.fillColor = UIColor.white.cgColor
        tabBar.layer.insertSublayer(shape, at: 0)
        tabBar.itemWidth = 40
        tabBar.itemPositioning = .centered
        tabBar.itemSpacing = 60
        tabBar.tintColor = UIColor(hex: "#fe989b", alpha: 1.0)
    }
    
    func configureMiddleButton() {
        btnMiddle.frame = CGRect(
            x: Int(tabBar.bounds.width) / 2 - 22,
            y: -22,
            width: 44,
            height: 44
        )
        tabBar.addSubview(btnMiddle)
    }
    
    func getPathForTabBar() -> UIBezierPath {
        let frameWidth = self.tabBar.bounds.width
        let frameHeight = self.tabBar.bounds.height + 40
        let holeWidth = 150
        let holeHeight = 50
        let leftXUntilHole = Int(frameWidth/2) - Int(holeWidth/2)
        
        let path : UIBezierPath = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: leftXUntilHole , y: 0)) // 1.Line
        
        // part I
        path.addCurve(
            to: CGPoint(x: leftXUntilHole + (holeWidth/3), y: holeHeight/2),
            controlPoint1: CGPoint(x: leftXUntilHole + ((holeWidth/3)/8)*6,y: 0),
            controlPoint2: CGPoint(x: leftXUntilHole + ((holeWidth/3)/8)*8, y: holeHeight/2)
        )
        
        // part II
        path.addCurve(
            to: CGPoint(x: leftXUntilHole + (2*holeWidth)/3, y: holeHeight/2),
            controlPoint1: CGPoint(x: leftXUntilHole + (holeWidth/3) + (holeWidth/3)/3*2/5, y: (holeHeight/2)*6/4),
            controlPoint2: CGPoint(x: leftXUntilHole + (holeWidth/3) + (holeWidth/3)/3*2 + (holeWidth/3)/3*3/5, y: (holeHeight/2)*6/4)
        )
        
        // part III
        path.addCurve(
            to: CGPoint(x: leftXUntilHole + holeWidth, y: 0),
            controlPoint1: CGPoint(x: leftXUntilHole + (2*holeWidth)/3,y: holeHeight/2),
            controlPoint2: CGPoint(x: leftXUntilHole + (2*holeWidth)/3 + (holeWidth/3)*2/8, y: 0)
        )
        
        path.addLine(to: CGPoint(x: frameWidth, y: 0)) // 2. Line
        path.addLine(to: CGPoint(x: frameWidth, y: frameHeight)) // 3. Line
        path.addLine(to: CGPoint(x: 0, y: frameHeight)) // 4. Line
        path.addLine(to: CGPoint(x: 0, y: 0)) // 5. Line
        path.close()
        return path
    }
    
    static func makeButton() -> UIButton {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        btn.setTitle("", for: .normal)
        btn.backgroundColor = UIColor(hex: "#fe989b", alpha: 1)
        btn.layer.cornerRadius = 22
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOpacity = 0.2
        btn.layer.shadowOffset = CGSize(width: 4, height: 4)
        btn.setBackgroundImage(UIImage(named: "icons8-plus"), for: .normal)
        return btn
    }
}
