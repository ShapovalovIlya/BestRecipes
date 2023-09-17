//
//  RecipeSummaryCell.swift
//  BestRecipes
//
//  Created by Илья Шаповалов on 17.09.2023.
//

import UIKit

final class RecipeSummaryCell: UICollectionViewCell {
    private let summaryText: UILabel = .makeLabel(
        font: .summaryText,
        color: .black,
        numberOfLines: 0
    )
    
    //MARK: - init(_:)
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(summaryText)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life cycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            summaryText.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Drawing.offset),
            summaryText.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -Drawing.offset),
            summaryText.topAnchor.constraint(equalTo: contentView.topAnchor),
            summaryText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    //MARK: - Public properties
    func configure(with summary: String?) {
        summaryText.text = summary?.convertFromHTML
    }
}

private extension RecipeSummaryCell {
    struct Drawing {
        static let offset: CGFloat = 10
    }
}
