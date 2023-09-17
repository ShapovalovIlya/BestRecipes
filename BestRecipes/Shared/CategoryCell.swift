//
//  RatedRecipeCell.swift
//  BestRecipes
//
//  Created by Илья Шаповалов on 27.08.2023.
//

import UIKit

final class CategoryCell: UICollectionViewCell {
    private let title = makeTitle()
    
    override var isSelected: Bool {
        didSet {
            super.isSelected = isSelected
            
            switch isSelected {
            case true:
                contentView.backgroundColor = .customRed
                title.textColor = .white
            case false:
                contentView.backgroundColor = .white
                title.textColor = .deselectedRed
            }
        }
    }
    
    //MARK: - init(_:)
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
        contentView.addSubview(title)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        title.text = nil
    }
    
    //MARK: - Public methods
    func configure(with category: MealType) {
        title.text = category.title
    }
    
}

private extension CategoryCell {
    static func makeTitle() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = .titleFont
        label.minimumScaleFactor = 0.8
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: contentView.topAnchor),
            title.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            title.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            title.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
