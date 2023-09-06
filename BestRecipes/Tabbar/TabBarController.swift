//
//  TabBarController.swift
//  BestRecipes
//
//  Created by Максим Нурутдинов on 04.09.2023.
//

import UIKit
import OSLog

final class TabBarController: UITabBarController {
    private let plusButton: UIButton = makeButton()
    
    //MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        
        setupTabBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureMiddleButton()
        Logger.viewCycle.debug("TabBarController: \(#function)")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let path: UIBezierPath = getPathFor(tabBar: tabBar.bounds)
        let shape = makeShapeWith(path: path.cgPath)
        tabBar.layer.insertSublayer(shape, at: 0)
    }
    
    //MARK: - Public methods
    func navigationControllers(_ controllers: UIViewController...) {
        self.viewControllers = controllers
    }
}

private extension TabBarController {
    //MARK: - Private methods
    func setupTabBar() {
        tabBar.itemWidth = 40
        tabBar.itemPositioning = .centered
        tabBar.itemSpacing = 60
        tabBar.tintColor = .tabBarTintColor
    }
    
    func makeShapeWith(path: CGPath) -> CAShapeLayer {
        let shape = CAShapeLayer()
        shape.path = path
        shape.lineWidth = 10
        shape.strokeColor = UIColor.white.cgColor
        shape.fillColor = UIColor.white.cgColor
        return shape
    }
    
    func configureMiddleButton() {
        plusButton.frame = CGRect(
            x: Int(tabBar.bounds.width) / 2 - 22,
            y: -22,
            width: 44,
            height: 44
        )
        tabBar.addSubview(plusButton)
    }
    
    func getPathFor(tabBar rect: CGRect) -> UIBezierPath {
        let frameWidth = rect.width
        let frameHeight = rect.height + 40
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
        let btn = UIButton()
        btn.setTitle("", for: .normal)
        btn.backgroundColor = .tabBarButtonColor
        btn.layer.cornerRadius = 22
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOpacity = 0.2
        btn.layer.shadowOffset = CGSize(width: 4, height: 4)
        btn.setBackgroundImage(.tabbarPlusIcon, for: .normal)
        return btn
    }
}
