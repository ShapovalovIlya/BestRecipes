//
//  TitleSupplementaryView.swift
//  BestRecipes
//
//  Created by Леонид Турко on 04.09.2023.
//

import UIKit

final class TitleSupplementaryView: UICollectionReusableView {
    let textLabel = UILabel()
    let numberLabel = UILabel()
    
    //MARK: - init(_:)
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init is not implemented")
    }
    
    //MARK: - Life cycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupLayout()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        textLabel.text = nil
        numberLabel.text = nil
    }
    
}

private extension TitleSupplementaryView {
    //MARK: - Private methods
    func setupSubviews() {
        textLabel.font = .preferredFont(forTextStyle: .title2)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(textLabel)
        addSubview(numberLabel)
    }
    
    func setupLayout() {
        let inset: CGFloat = 10
        
        NSLayoutConstraint.activate([
            textLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
            textLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset),
            textLabel.topAnchor.constraint(equalTo: topAnchor, constant: inset),
            textLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -inset),
            
            //numberLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
            numberLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset),
            numberLabel.topAnchor.constraint(equalTo: topAnchor, constant: inset),
            numberLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -inset),
        ])
    }
}

