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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let path: UIBezierPath = makePath(in: tabBar.frame)
        let shape = makeShapeWith(path: path.cgPath)
        tabBar.layer.insertSublayer(shape, at: 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !UserDefaults().bool(forKey: "isOnboarded") {
            let onboarding = OnboardingViewController()
            onboarding.modalPresentationStyle = .automatic
            onboarding.modalTransitionStyle = .coverVertical
            self.present(onboarding, animated: true)
        }
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
        tabBar.tintColor = .customRed
    }
    
    func makeShapeWith(path: CGPath) -> CAShapeLayer {
        let shape = CAShapeLayer()
        shape.path = path
        shape.lineWidth = 10
        shape.strokeColor = UIColor.white.cgColor
        shape.fillColor = UIColor.white.cgColor
        shape.shadowColor = UIColor.black.cgColor
        shape.shadowOpacity = 1
        shape.shadowOffset = CGSize(width: 0, height: 4)
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
    
    func makePath(in rect: CGRect) -> UIBezierPath {
        let path = UIBezierPath()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.02046*width, y: 0.07377*height))
        path.addLine(to: CGPoint(x: 0.36093*width, y: 0.07377*height))
        
        path.addCurve(
            to: CGPoint(x: 0.41725*width, y: 0.20512*height),
            controlPoint1: CGPoint(x: 0.38586*width, y: 0.07377*height),
            controlPoint2: CGPoint(x: 0.40698*width, y: 0.13233*height)
        )
        path.addCurve(
            to: CGPoint(x: 0.50128*width, y: 0.40984*height),
            controlPoint1: CGPoint(x: 0.43055*width, y: 0.29939*height),
            controlPoint2: CGPoint(x: 0.45583*width, y: 0.40984*height)
        )
        path.addCurve(
            to: CGPoint(x: 0.58531*width, y: 0.20512*height),
            controlPoint1: CGPoint(x: 0.54673*width, y: 0.40984*height),
            controlPoint2: CGPoint(x: 0.57201*width, y: 0.29939*height)
        )
        path.addCurve(
            to: CGPoint(x: 0.64162*width, y: 0.07377*height),
            controlPoint1: CGPoint(x: 0.59558*width, y: 0.13233*height),
            controlPoint2: CGPoint(x: 0.6167*width, y: 0.07377*height)
        )
        path.addLine(to: CGPoint(x: 0.97954*width, y: 0.07377*height))
        path.addLine(to: CGPoint(x: 0.97954*width, y: 0.94262*height))
        path.addLine(to: CGPoint(x: 0.02046*width, y: 0.94262*height))
        path.addLine(to: CGPoint(x: 0.02046*width, y: 0.07377*height))
        path.close()
        return path
    }
    
    static func makeButton() -> UIButton {
        let button = UIButton()
        button.setImage(.tabbarPlusIcon, for: .normal)
        button.backgroundColor = .customRed
        button.layer.cornerRadius = 22
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.2
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        return button
    }
}
