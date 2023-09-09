//
//  HeaderView.swift
//  BestRecipes
//
//  Created by Леонид Турко on 04.09.2023.
//

import UIKit

final class HeaderView: UICollectionReusableView {
    private struct Drawing {
        static let offset: CGFloat = 10
    }
    
    private let titleLabel: UILabel = .makeLabel(
        font: .titleFont,
        color: .black
    )
    
    //MARK: - init(_:)
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init is not implemented")
    }
    
    //MARK: - Life cycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = nil
    }
    
    //MARK: - Public Methods
    func configure(title: String) {
        titleLabel.text = title
    }
    
    func addButton(target: AnyObject, action: Selector) {
        let seeAllButton = makeButton()
        seeAllButton.addTarget(
            target,
            action: action,
            for: .touchUpInside
        )
        addSubview(seeAllButton)
        makeConstraints(for: seeAllButton)
    }
    
    func configure(subtitle: String) {
        
    }
    
}

private extension HeaderView {
    //MARK: - Private methods
    func makeButton() -> UIButton {
        var configuration = UIButton.Configuration.plain()
        configuration.baseForegroundColor = .tabBarTintColor
        configuration.title = "See all"
        configuration.image = .rightArrow
        configuration.imagePlacement = .trailing
        configuration.imagePadding = 5
        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    func makeConstraints(for button: UIButton) {
        NSLayoutConstraint.activate([
            button.rightAnchor.constraint(equalTo: rightAnchor, constant: -Drawing.offset),
            button.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: Drawing.offset),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

