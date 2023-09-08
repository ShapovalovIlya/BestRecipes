//
//  TrendingRecipeCell.swift
//  BestRecipes
//
//  Created by Dmitriy Eliseev on 06.09.2023.
//

import UIKit
import Kingfisher

final class TrendingRecipeCell: UICollectionViewCell {
    //MARK: - Private properties
    private struct Drawing {
        static let recipeImageHeight: CGFloat = 180
        static let creatorImageHeight: CGFloat = 32
        static let verticalSpacing: CGFloat = 10
        static let burgerButtonHeight: CGFloat = 20
    }
    
    private let stackVertical: UIStackView = makeStack(
        axis: .vertical,
        spacing: Drawing.verticalSpacing
    )
    private let stackTitle: UIStackView = makeStack(
        axis: .horizontal,
        distribution: .equalCentering
    )
    private let recipeImageView: UIImageView = makeImageView()
    private let titleLabel: UILabel = makeLabel(
        font: .titleFont,
        color: .titleTextColor
    )
    private let stackCreator = makeStack(
        axis: .horizontal,
        distribution: .equalCentering
    )
    private let creatorImage: UIImageView = makeImageView()
    private let burgerButton = makeButtonBurger()
    private let creatorLabel = makeLabel(
        font: .creatorTitleFont,
        color: .creatorLabelColor
    )
    private let fistButtonSize = CGSize(
        width: 32,
        height: 32
    )
    private let buttonBookmark = makeButtonBookmark()
    private let raitingButton = RaitingButton(
        buttonSize: CGSize(
            width: 58,
            height: 28
        ),
        buttonRadius: 8,
        buttonColor: "303030",
        buttonAlfa: 0.7,
        buttonImage: "star.fill",
        buttonImageSize: CGSize(
            width: 12,
            height: 12
        ),
        buttonImageOriginX: 8,
        buttonFont: UIFont(
            name: "Arial-BoldMT",
            size: 16
        )!,
        buttonTextColor: "FFFFFF",
        buttonLableSize: CGSize(
            width: 24,
            height: 20
        ),
        buttonLableOriginX: 27,
        buttonText: "4,5",
        buttonImageColor: "181818"
    )
    private lazy var raiting = TrendingRecipeCell.makeButtonRaiting(
        parameters:
            raitingButton
    )
   
    //MARK: - init(_:)
    override init(frame: CGRect) {
        super .init(frame: frame)
        backgroundColor = .white
        contentView.addSubviews(
              stackVertical,
              recipeImageView,
              stackTitle,
              titleLabel,
              burgerButton,
              stackCreator,
              creatorImage,
              creatorLabel,
              buttonBookmark,
              raiting
        )
        
        stackVertical.addArrangedSubviews(
            recipeImageView,
            stackTitle,
            stackCreator
        )
        
        stackTitle.addArrangedSubviews(
            titleLabel,
            burgerButton
        )
        
        stackCreator.addArrangedSubviews(
            creatorImage,
            creatorLabel
        )
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Life Cycle
    override func layoutSubviews() {
        super.layoutSubviews()
        setupTest()
        setupConstraints()
        
        creatorImage.layer.cornerRadius = creatorImage.frame.height / 2
    }
    
    //MARK: - Public methods
    func configure(with recipe: Recipe) {
        recipeImageView.kf.setImage(with: URL(string: recipe.image))
        titleLabel.text = recipe.title
        creatorLabel.text = recipe.sourceName
    }
    
    
    private func setupTest() {
        recipeImageView.image = UIImage(named: "test_img")
        creatorImage.image = UIImage(named: "creator")
        titleLabel.text = "How to sharwama at home"
        creatorLabel.text = "By Zeelicious foods"
    }
    
    //MARK: - private funcs
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackVertical.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackVertical.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackVertical.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackVertical.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            recipeImageView.leadingAnchor.constraint(equalTo: stackVertical.leadingAnchor),
            recipeImageView.topAnchor.constraint(equalTo: stackVertical.topAnchor),
            recipeImageView.trailingAnchor.constraint(equalTo: stackVertical.trailingAnchor),
            recipeImageView.heightAnchor.constraint(equalToConstant: Drawing.recipeImageHeight),
            
            stackTitle.leadingAnchor.constraint(equalTo: stackVertical.leadingAnchor),
            stackTitle.trailingAnchor.constraint(equalTo: stackVertical.trailingAnchor),
            
            burgerButton.heightAnchor.constraint(equalToConstant: Drawing.burgerButtonHeight),
            burgerButton.trailingAnchor.constraint(equalTo: stackTitle.trailingAnchor),
            
            stackCreator.leadingAnchor.constraint(equalTo: stackVertical.leadingAnchor),
            stackCreator.heightAnchor.constraint(equalToConstant: Drawing.creatorImageHeight),
            stackCreator.trailingAnchor.constraint(equalTo: stackVertical.trailingAnchor, constant: -10),
            
            creatorImage.heightAnchor.constraint(equalTo: creatorImage.widthAnchor),
            creatorLabel.leadingAnchor.constraint(equalTo: creatorImage.trailingAnchor, constant: 10),
            
            buttonBookmark.topAnchor.constraint(equalTo: stackVertical.topAnchor, constant: 8),
            buttonBookmark.trailingAnchor.constraint(equalTo: stackVertical.trailingAnchor, constant: -8),
            buttonBookmark.heightAnchor.constraint(equalTo: buttonBookmark.widthAnchor),
            buttonBookmark.heightAnchor.constraint(equalToConstant: fistButtonSize.height),
            
            raiting.leadingAnchor.constraint(equalTo: stackVertical.leadingAnchor, constant: 10),
            raiting.topAnchor.constraint(equalTo: stackVertical.topAnchor, constant: 10),
            raiting.widthAnchor.constraint(equalToConstant: raitingButton.buttonSize.width),
            raiting.heightAnchor.constraint(equalToConstant: raitingButton.buttonSize.height)
        ])}

}

private extension TrendingRecipeCell{
    static func makeStack(
        axis: NSLayoutConstraint.Axis,
        spacing: CGFloat = 0,
        distribution: UIStackView.Distribution = .fill
    ) -> UIStackView {
        let stack = UIStackView()
        stack.axis = axis
        stack.alignment = .center
        stack.backgroundColor = .white
        stack.distribution = distribution
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = spacing
        return stack
    }
    
    static func makeLabel(
        font: UIFont?,
        color: UIColor?,
        numberOfLines: Int = 1
    ) -> UILabel {
        let lableView = UILabel()
        lableView.numberOfLines = numberOfLines
        lableView.font = font
        lableView.textColor = color
        lableView.adjustsFontSizeToFitWidth = true
        lableView.minimumScaleFactor = 0.5
        lableView.translatesAutoresizingMaskIntoConstraints = false
        return lableView
    }
    
    static func makeImageView() -> UIImageView {
        let mediaImageView = UIImageView()
        mediaImageView.layer.cornerRadius = 8
        mediaImageView.clipsToBounds = true
        mediaImageView.translatesAutoresizingMaskIntoConstraints = false
        return mediaImageView
    }
    
    static func makeButtonBurger() -> UIButton {
        var btnConf = UIButton.Configuration.plain()
        btnConf.image = .burgerButtonImage
        let buttonTitleView = UIButton(configuration: btnConf)
        buttonTitleView.imageView?.contentMode = .scaleAspectFit
        buttonTitleView.contentMode = .scaleAspectFill
        buttonTitleView.backgroundColor = .white
        buttonTitleView.frame.size = .init(width: 20, height: 20)
        buttonTitleView.imageView?.frame = buttonTitleView.frame
        buttonTitleView.translatesAutoresizingMaskIntoConstraints = false
        return buttonTitleView
    }
    static func makeButtonBookmark() -> UIButton {
        let buttonBookmarkView = UIButton(type: .custom)
        buttonBookmarkView.frame.size = .init(
            width: 32,
            height: 32
        )
        buttonBookmarkView.backgroundColor = .white
        buttonBookmarkView.layer.cornerRadius = buttonBookmarkView.frame.height/2
        let imageView = UIImageView()
        imageView.frame.size = CGSize(
            width: 21.33,
            height: 21.33
        )
        imageView.image = .bookmarkImage
        buttonBookmarkView.addSubview(imageView)
        imageView.contentMode = .center
        imageView.contentMode = .scaleAspectFit
        imageView.center = buttonBookmarkView.center
        buttonBookmarkView.translatesAutoresizingMaskIntoConstraints = false
        return buttonBookmarkView
    }
    
    static func makeButtonRaiting(parameters: RaitingButton) -> UIButton {
            let ratingButton = UIButton(type: .custom)
        ratingButton.frame.size = parameters.buttonSize
        ratingButton.backgroundColor = UIColor(hex: parameters.buttonColor)
        ratingButton.alpha = parameters.buttonAlfa
        ratingButton.layer.cornerRadius = parameters.buttonRadius
        let image = UIImage(systemName: parameters.buttonImage)
        let imageView = UIImageView()
        imageView.frame.size = parameters.buttonImageSize
        imageView.frame.origin = .init(x: parameters.buttonImageOriginX, y: ((parameters.buttonSize.height-parameters.buttonImageSize.height)/2))
        imageView.image = image
        ratingButton.addSubview(imageView)
        let textFont = parameters.buttonFont
        let lableView = UILabel()
        lableView.font = textFont
        lableView.textColor = UIColor(hex: parameters.buttonTextColor, alpha: 1)
        lableView.adjustsFontSizeToFitWidth = true
        lableView.minimumScaleFactor = 0.5
        lableView.text = parameters.buttonText
        lableView.frame.size = parameters.buttonLableSize
        lableView.frame.origin = .init(x: parameters.buttonLableOriginX, y: ((parameters.buttonSize.height-lableView.frame.size.height)/2))
        ratingButton.addSubview(lableView)
        ratingButton.tintColor = UIColor(hex: parameters.buttonImageColor)
        ratingButton.translatesAutoresizingMaskIntoConstraints = false
            return ratingButton
        }
    
}

private struct RaitingButton {
    var buttonSize: CGSize
    var buttonRadius: CGFloat
    var buttonColor: String
    var buttonAlfa: CGFloat
    var buttonImage: String
    var buttonImageSize: CGSize
    var buttonImageOriginX: CGFloat
    var buttonFont: UIFont
    var buttonTextColor: String
    var buttonLableSize: CGSize
    var buttonLableOriginX: CGFloat
    var buttonText: String
    var buttonImageColor: String
}

import SwiftUI
@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, xrOS 1.0, *)
#Preview {
    TrendingRecipeCell()
}
