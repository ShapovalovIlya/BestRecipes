//
//  OnboardingViewController.swift
//  BestRecipes
//
//  Created by Илья Шаповалов on 27.08.2023.
//

import UIKit

class OnboardingViewController: UIViewController {

    lazy var onboardingScrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceHorizontal = true
        scrollView.isPagingEnabled = true
        scrollView.isScrollEnabled = false
        
        return scrollView
    }()
    
    lazy var backgroundViewOnboarding: UIView = {
        let image = UIView(frame: .zero)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        
        return image
    }()
    
    lazy var backgroundViewOnboarding1: UIView = {
        let image = UIView(frame: .zero)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        
        return image
    }()
    
    lazy var backgroundViewOnboarding2: UIView = {
        let image = UIView(frame: .zero)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        
        return image
    }()
    
    lazy var backgroundViewOnboarding3: UIView = {
        let image = UIView(frame: .zero)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        
        return image
    }()
    
    lazy var backgroundImageOnboarding: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "onboarding")
        image.contentMode = .scaleAspectFill
       
        return image
    }()
    
    lazy var recipesCountLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "★ 100k+ Premium recipes"
        label.textColor = .white
    
        return label
    }()
    
    lazy var bestRecipeTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Best\nRecipe"
        label.font = .systemFont(ofSize: 80, weight: .heavy)
        label.numberOfLines = 2
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    lazy var bestRecipeSubtitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Find best recipes for cooking"
        label.textColor = .white
        
        return label
    }()
    
    lazy var getStartedButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Get started", for: .normal)
        button.backgroundColor = UIColor(named: "onboardingColor")
        button.layer.cornerRadius = 5
        
        return button
    }()
    
    lazy var onboardingPageControl: UIPageControl = {
        let pageControl = UIPageControl(frame: .zero)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.numberOfPages = 3
        pageControl.isHidden = true
        pageControl.currentPageIndicatorTintColor = UIColor(named: "onboardingLabelAdditional")
        
        return pageControl
    }()
    
    lazy var backgroundImageOnboardingPage1: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "onboarding1")
        image.contentMode = .scaleAspectFill
        
        return image
    }()
    
    lazy var page1Label: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        var text = "Recipes from\nall over the\nWorld"
        var textAttributedString = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 36, weight: .heavy)])
        textAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(named: "onboardingLabelAdditional") ?? .yellow, range: NSRange(location: 12, length: 19))
        label.numberOfLines = 0
        label.attributedText = textAttributedString
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var page1ContinueButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Continue", for: .normal)
        button.backgroundColor = UIColor(named: "onboardingColor")
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(didTapChangeScrollPosition), for: .touchUpInside)
        
        return button
    }()
    
    lazy var page1SkipButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Skip", for: .normal)
        button.backgroundColor = .clear
        button.tintColor = .white
        button.addTarget(self, action: #selector(didTapCloseScreen), for: .touchUpInside)
        
        return button
    }()
    
    lazy var backgroundImageOnboardingPage2: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "onboarding2")
        image.contentMode = .scaleAspectFill
        
        return image
    }()
    
    lazy var page2Label: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        var text = "Recipes with\neach and every\ndetail"
        var textAttributedString = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 50, weight: .heavy)])
        textAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(named: "onboardingLabelAdditional") ?? .yellow, range: NSRange(location: 13, length: 21))
        label.numberOfLines = 0
        label.attributedText = textAttributedString
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var page2ContinueButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Continue", for: .normal)
        button.backgroundColor = UIColor(named: "onboardingColor")
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(didTapChangeScrollPosition), for: .touchUpInside)
    
        return button
    }()
    
    lazy var page2SkipButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Skip", for: .normal)
        button.backgroundColor = .clear
        button.tintColor = .white
        button.addTarget(self, action: #selector(didTapCloseScreen), for: .touchUpInside)
        
        return button
    }()
    
    lazy var backgroundImageOnboardingPage3: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "onboarding3")
        image.contentMode = .scaleAspectFill

        return image
    }()
    
    lazy var page3Label: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        var text = "Cook it now or\nsave it for later"
        var textAttributedString = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 50, weight: .heavy)])
        textAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(named: "onboardingLabelAdditional") ?? .yellow, range: NSRange(location: 15, length: 17))
        label.attributedText = textAttributedString
        label.numberOfLines = 0
        
        return label
    }()
    
    lazy var startCookingButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Start Cooking", for: .normal)
        button.backgroundColor = UIColor(named: "onboardingColor")
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(didTapCloseScreen), for: .touchUpInside)
        
        return button
    }()
    
    override func loadView() {
        view = onboardingScrollView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        onboardingScrollView.addSubview(backgroundViewOnboarding)
        onboardingScrollView.addSubview(backgroundViewOnboarding1)
        onboardingScrollView.addSubview(backgroundViewOnboarding2)
        onboardingScrollView.addSubview(backgroundViewOnboarding3)
        onboardingScrollView.addSubview(onboardingPageControl)
        
        backgroundViewOnboarding.addSubview(backgroundImageOnboarding)
        backgroundViewOnboarding.addSubview(recipesCountLabel)
        backgroundViewOnboarding.addSubview(bestRecipeTitle)
        backgroundViewOnboarding.addSubview(bestRecipeSubtitle)
        backgroundViewOnboarding.addSubview(getStartedButton)
        
        backgroundViewOnboarding1.addSubview(backgroundImageOnboardingPage1)
        backgroundViewOnboarding1.addSubview(page1Label)
        backgroundViewOnboarding1.addSubview(page1ContinueButton)
        backgroundViewOnboarding1.addSubview(page1SkipButton)
        
        backgroundViewOnboarding2.addSubview(backgroundImageOnboardingPage2)
        backgroundViewOnboarding2.addSubview(page2Label)
        backgroundViewOnboarding2.addSubview(page2ContinueButton)
        backgroundViewOnboarding2.addSubview(page2SkipButton)
        
        
        backgroundViewOnboarding3.addSubview(backgroundImageOnboardingPage3)
        backgroundViewOnboarding3.addSubview(page3Label)
        backgroundViewOnboarding3.addSubview(startCookingButton)
        
        NSLayoutConstraint.activate([
            backgroundViewOnboarding.topAnchor.constraint(equalTo: onboardingScrollView.contentLayoutGuide.topAnchor),
            backgroundViewOnboarding.leadingAnchor.constraint(equalTo: onboardingScrollView.contentLayoutGuide.leadingAnchor),
            backgroundViewOnboarding.widthAnchor.constraint(equalTo: onboardingScrollView.frameLayoutGuide.widthAnchor),
            backgroundViewOnboarding.heightAnchor.constraint(equalTo: onboardingScrollView.frameLayoutGuide.heightAnchor),
            
            backgroundImageOnboarding.topAnchor.constraint(equalTo: backgroundViewOnboarding.topAnchor),
            backgroundImageOnboarding.leadingAnchor.constraint(equalTo: backgroundViewOnboarding.leadingAnchor),
            backgroundImageOnboarding.trailingAnchor.constraint(equalTo: backgroundViewOnboarding.trailingAnchor),
            backgroundImageOnboarding.bottomAnchor.constraint(equalTo: backgroundViewOnboarding.bottomAnchor),
            
            backgroundImageOnboardingPage1.topAnchor.constraint(equalTo: backgroundViewOnboarding1.topAnchor),
            backgroundImageOnboardingPage1.leadingAnchor.constraint(equalTo: backgroundViewOnboarding1.leadingAnchor),
            backgroundImageOnboardingPage1.trailingAnchor.constraint(equalTo: backgroundViewOnboarding1.trailingAnchor),
            backgroundImageOnboardingPage1.bottomAnchor.constraint(equalTo: backgroundViewOnboarding1.bottomAnchor),
            
            backgroundImageOnboardingPage2.topAnchor.constraint(equalTo: backgroundViewOnboarding2.topAnchor),
            backgroundImageOnboardingPage2.leadingAnchor.constraint(equalTo: backgroundViewOnboarding2.leadingAnchor),
            backgroundImageOnboardingPage2.trailingAnchor.constraint(equalTo: backgroundViewOnboarding2.trailingAnchor),
            backgroundImageOnboardingPage2.bottomAnchor.constraint(equalTo: backgroundViewOnboarding2.bottomAnchor),
            
            backgroundImageOnboardingPage3.topAnchor.constraint(equalTo: backgroundViewOnboarding3.topAnchor),
            backgroundImageOnboardingPage3.leadingAnchor.constraint(equalTo: backgroundViewOnboarding3.leadingAnchor),
            backgroundImageOnboardingPage3.trailingAnchor.constraint(equalTo: backgroundViewOnboarding3.trailingAnchor),
            backgroundImageOnboardingPage3.bottomAnchor.constraint(equalTo: backgroundViewOnboarding3.bottomAnchor),
            
            onboardingPageControl.centerXAnchor.constraint(equalTo: onboardingScrollView.frameLayoutGuide.centerXAnchor),
            onboardingPageControl.bottomAnchor.constraint(equalTo: onboardingScrollView.frameLayoutGuide.bottomAnchor, constant: -130),
            
            recipesCountLabel.topAnchor.constraint(equalTo: backgroundViewOnboarding.topAnchor, constant: 80),
            recipesCountLabel.centerXAnchor.constraint(equalTo: backgroundViewOnboarding.centerXAnchor),
            
            getStartedButton.bottomAnchor.constraint(equalTo: backgroundViewOnboarding.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            getStartedButton.centerXAnchor.constraint(equalTo: backgroundViewOnboarding.centerXAnchor),
            getStartedButton.widthAnchor.constraint(equalTo: backgroundViewOnboarding.widthAnchor, multiplier: 0.33),
            getStartedButton.heightAnchor.constraint(equalToConstant: 56),
            
            bestRecipeSubtitle.bottomAnchor.constraint(equalTo: getStartedButton.topAnchor, constant: -24),
            bestRecipeSubtitle.centerXAnchor.constraint(equalTo: backgroundViewOnboarding.centerXAnchor),
            
            bestRecipeTitle.bottomAnchor.constraint(equalTo: bestRecipeSubtitle.topAnchor, constant: -16),
            bestRecipeTitle.centerXAnchor.constraint(equalTo: backgroundViewOnboarding.centerXAnchor),
            
            backgroundViewOnboarding1.topAnchor.constraint(equalTo: onboardingScrollView.frameLayoutGuide.topAnchor),
            backgroundViewOnboarding1.leadingAnchor.constraint(equalTo: backgroundViewOnboarding.trailingAnchor),
            backgroundViewOnboarding1.widthAnchor.constraint(equalTo: backgroundViewOnboarding.widthAnchor),
            backgroundViewOnboarding1.heightAnchor.constraint(equalTo: backgroundViewOnboarding.heightAnchor),
            
            page1SkipButton.bottomAnchor.constraint(equalTo: backgroundViewOnboarding1.safeAreaLayoutGuide.bottomAnchor),
            page1SkipButton.centerXAnchor.constraint(equalTo: backgroundViewOnboarding1.centerXAnchor),
            
            page1ContinueButton.widthAnchor.constraint(equalTo: backgroundViewOnboarding1.widthAnchor, multiplier: 0.5),
            page1ContinueButton.heightAnchor.constraint(equalToConstant: 44),
            page1ContinueButton.centerXAnchor.constraint(equalTo: backgroundViewOnboarding1.centerXAnchor),
            page1ContinueButton.bottomAnchor.constraint(equalTo: page1SkipButton.topAnchor, constant: -20),
            
            page1Label.bottomAnchor.constraint(equalTo: page1ContinueButton.topAnchor, constant: -20),
            page1Label.centerXAnchor.constraint(equalTo: backgroundImageOnboardingPage1.centerXAnchor),
            
            backgroundViewOnboarding2.topAnchor.constraint(equalTo: onboardingScrollView.frameLayoutGuide.topAnchor),
            backgroundViewOnboarding2.leadingAnchor.constraint(equalTo: backgroundImageOnboardingPage1.trailingAnchor),
            backgroundViewOnboarding2.widthAnchor.constraint(equalTo: backgroundImageOnboardingPage1.widthAnchor),
            backgroundViewOnboarding2.heightAnchor.constraint(equalTo: backgroundImageOnboardingPage1.heightAnchor),

            page2SkipButton.bottomAnchor.constraint(equalTo: backgroundViewOnboarding2.safeAreaLayoutGuide.bottomAnchor),
            page2SkipButton.centerXAnchor.constraint(equalTo: backgroundViewOnboarding2.centerXAnchor),

            page2ContinueButton.widthAnchor.constraint(equalTo: backgroundViewOnboarding2.widthAnchor, multiplier: 0.5),
            page2ContinueButton.heightAnchor.constraint(equalToConstant: 44),
            page2ContinueButton.centerXAnchor.constraint(equalTo: backgroundViewOnboarding2.centerXAnchor),
            page2ContinueButton.bottomAnchor.constraint(equalTo: page2SkipButton.topAnchor, constant: -20),

            page2Label.bottomAnchor.constraint(equalTo: page2ContinueButton.topAnchor, constant: -20),
            page2Label.centerXAnchor.constraint(equalTo: backgroundViewOnboarding2.centerXAnchor),
            
            backgroundViewOnboarding3.topAnchor.constraint(equalTo: onboardingScrollView.frameLayoutGuide.topAnchor),
            backgroundViewOnboarding3.leadingAnchor.constraint(equalTo: backgroundViewOnboarding2.trailingAnchor),
            backgroundViewOnboarding3.trailingAnchor.constraint(equalTo: onboardingScrollView.contentLayoutGuide.trailingAnchor),
            backgroundViewOnboarding3.widthAnchor.constraint(equalTo: backgroundImageOnboardingPage1.widthAnchor),
            backgroundViewOnboarding3.heightAnchor.constraint(equalTo: backgroundImageOnboardingPage1.heightAnchor),

            startCookingButton.widthAnchor.constraint(equalTo: backgroundViewOnboarding3.widthAnchor, multiplier: 0.5),
            startCookingButton.heightAnchor.constraint(equalToConstant: 44),
            startCookingButton.centerXAnchor.constraint(equalTo: backgroundViewOnboarding3.centerXAnchor),
            startCookingButton.bottomAnchor.constraint(equalTo: backgroundViewOnboarding3.safeAreaLayoutGuide.bottomAnchor, constant: -54),

            page3Label.bottomAnchor.constraint(equalTo: startCookingButton.topAnchor, constant: -20),
            page3Label.centerXAnchor.constraint(equalTo: backgroundViewOnboarding3.centerXAnchor),
            
        ])
        
        getStartedButton.addTarget(self, action: #selector(didTapChangeScrollPosition), for: .touchUpInside)
    }
    
    @objc
    func didTapChangeScrollPosition() {
        let width = onboardingScrollView.frame.width
        guard onboardingScrollView.contentOffset.x + width <= width * 4 else { return }
        onboardingScrollView.setContentOffset(
            CGPoint(x: onboardingScrollView.contentOffset.x + width, y: onboardingScrollView.contentOffset.y),
            animated: true
        )
        
        onboardingPageControl.isHidden = false
        onboardingPageControl.currentPage = Int(onboardingScrollView.contentOffset.x / width)
    }
    
    @objc func didTapCloseScreen() {
        dismiss(animated: true)
        UserDefaults().setValue(true, forKey: "isOnboarded")
    }
}
