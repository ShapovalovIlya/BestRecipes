//
//  RecentRecipeCell.swift
//  BestRecipes
//
//  Created by Dmitriy Eliseev on 06.09.2023.
//

import UIKit

struct ImageDrawing {
    var imageName:String
    var imageSize: CGSize
    var radiusImage: CGFloat
}

struct StackDrawing {
    var offset: BoundBox
    var spacing: CGFloat
}

struct BoundBox {
    var leading: CGFloat
    var trailing: CGFloat
    var top: CGFloat
    var bottom: CGFloat
}

final class RecentRecipeCell: UICollectionViewCell {
    private struct Drawing {
        static let imageHeight: CGFloat = 124
    }
    //MARK: - Private properties
    private let recipeImage: UIImageView = makeImageView()
    
    private let scaleData = ScaleFactorData(
        stackTrailing: 0.95,
        lableFirstHeigth: 0.19,
        lableSecondHeigth: 0.066,
        stackSpacing: 0.019
    )
    private let stackParameters = StackDrawing(
        offset:
            BoundBox(
                leading: 5,
                trailing: -5,
                top: 5,
                bottom: -5),
        spacing: 0
    )
    private let stackVertical = makeStackVertical()
    private let stackVerticalInfo = RecentRecipeCell.makeStackInfoVertical()
    private let foodImageParameters = ImageDrawing(
        imageName: "foodPhoto",
        imageSize: CGSize(
            width: 124,
            height: 124
        ),
        radiusImage: 12
    )
    private lazy var foodImage: UIImageView = RecentRecipeCell.makeImageFood(
        parameters: foodImageParameters
    )
    private let textFirstInfoLable = TextParameters(
        text: "Kelewele Ghanian Recipe",
        colorHex: "181818",
        textName: "Arial-BoldMT",
        textSize: 16,
        lines: 2,
        lableBox: BoundBox(
            leading: 0,
            trailing: 0,
            top: 0,
            bottom: 0
        )
    )
    private lazy var lableFirstInfo: UILabel = RecentRecipeCell.makeLable(
        params: textFirstInfoLable
    )
    private let textSecondInfoLable = TextParameters(
        text: "By Zeelicious Foods",
        colorHex: "919191",
        textName: "ArialMT",
        textSize: 12,
        lines: 1,
        lableBox: BoundBox(
            leading: 0,
            trailing: 0,
            top: 0,
            bottom: 0
        )
    )
    private lazy var lableSecondInfo: UILabel = RecentRecipeCell.makeLable(params: textSecondInfoLable)
    
    //MARK: - init(_:)
    override init(frame: CGRect) {
        super .init(frame: frame)
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life Cycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.addSubviews(
            recipeImage
        )
        
        setupConstraints()
    }
    //MARK: - Private methods
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            recipeImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            recipeImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            recipeImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            recipeImage.heightAnchor.constraint(equalToConstant: Drawing.imageHeight),
        ])
    }
    
}

//MARK: - Private extensions
private extension RecentRecipeCell {
    static func makeImageView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    static func makeStackVertical() -> UIStackView {
        let stackVerticalView = UIStackView()
        stackVerticalView.axis = .vertical
        stackVerticalView.backgroundColor = .clear
        stackVerticalView.translatesAutoresizingMaskIntoConstraints = false
        return stackVerticalView
    }
    
    static func makeStackInfoVertical() -> UIStackView {
        let stackInfoVerticalView = UIStackView()
        stackInfoVerticalView.axis = .vertical
        stackInfoVerticalView.backgroundColor = .clear
        stackInfoVerticalView.translatesAutoresizingMaskIntoConstraints = false
        return stackInfoVerticalView
    }
    
    static func makeImageFood(parameters: ImageDrawing) -> UIImageView {
        let foodImageView = UIImageView()
        foodImageView.frame.size = parameters.imageSize
        foodImageView.image = UIImage(named: parameters.imageName)
        foodImageView.layer.cornerRadius = parameters.radiusImage
        foodImageView.clipsToBounds = true
        foodImageView.translatesAutoresizingMaskIntoConstraints = false
        return foodImageView
    }
    
    static func makeSecondInfoLable(text: String) -> UILabel {
        let lableView = UILabel()
        lableView.adjustsFontSizeToFitWidth = true
        lableView.text = text
        lableView.translatesAutoresizingMaskIntoConstraints = false
        return lableView
    }
    
//    static func makeFirstInfoLable(text: String) -> UILabel {
//        let lableView = UILabel()
//        lableView.numberOfLines = 2//нужно ли выносить?
//        lableView.lineBreakMode = .byClipping
//        lableView.minimumScaleFactor = 1//нужно ли выносить?
//        lableView.adjustsFontSizeToFitWidth = true
//        lableView.text = text
//        lableView.translatesAutoresizingMaskIntoConstraints = false
//        return lableView
//    }
    static func makeLable(params: TextParameters) -> UILabel {
        let lableView = UILabel()
        lableView.numberOfLines = params.lines
        let textFont = UIFont(name: params.textName, size: params.textSize)
        lableView.font = textFont
        lableView.textColor = UIColor(hex: params.colorHex, alpha: 1)
        lableView.adjustsFontSizeToFitWidth = true
        lableView.minimumScaleFactor = 0.5
        lableView.text = params.text
        lableView.translatesAutoresizingMaskIntoConstraints = false
        return lableView
    }
}

//MARK: - private structure
private struct ScaleFactorData {
    var stackTrailing: CGFloat
    var lableFirstHeigth: CGFloat
    var lableSecondHeigth: CGFloat
    var stackSpacing: CGFloat
}

import SwiftUI
@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, xrOS 1.0, *)
#Preview {
    RecentRecipeCell()
}
