//
//  FrameThreeCollectionViewCell.swift
//  BestRecipes
//
//  Created by Dmitriy Eliseev on 06.09.2023.
//

import UIKit

struct TextParameters {
    var text: String
    var colorHex: String
    var textName: String
    var textSize: CGFloat
    var lines: Int
    var lableBox: BoundBox
}

final class FrameThreeCollectionViewCell: UICollectionViewCell {
    //MARK: - Private lets and vars
    private let stackParameters = StackDrawing(
        offset:
            BoundBox(
                leading: 12,
                trailing: -12,
                top: 2,
                bottom: -12),
        spacing: 0
    )
    private let stackVertical = FrameThreeCollectionViewCell.makeStackVertical()
    private let foodImageParameters = ImageDrawing(
        imageName: "foodPhoto",
        imageSize: CGSize(width: 110, height: 110),
        radiusImage: 110/2
    )
    private lazy var foodImage: UIImageView = FrameThreeCollectionViewCell.makeImageFood(
        parameters:
            foodImageParameters
    )
    private let firstLable = TextParameters(
        text: "Chicken and Vegetable wrap",
        colorHex: "181818",
        textName: "Arial-BoldMT",
        textSize: 18, lines: 2,
        lableBox: BoundBox(
            leading: 0,
            trailing: 0,
            top: 12,
            bottom: 16
        )
    )
    private lazy var lableFirst: UILabel = FrameThreeCollectionViewCell.makeLable(
        params:
            firstLable
    )
    private lazy var downViewForContent: UIView = FrameThreeCollectionViewCell.makeView()
    private let secondLable = TextParameters(
        text: "Time",
        colorHex: "C1C1C1",
        textName: "ArialMT",
        textSize: 14,
        lines: 1,
        lableBox: BoundBox(
            leading: 0,
            trailing: 0,
            top: 0,
            bottom: 0
        )
    )
    private lazy var lableSecondTime: UILabel = FrameThreeCollectionViewCell.makeLable(
        params:
            secondLable
    )
    private let thirdLable = TextParameters(
        text: "5 Mins",
        colorHex: "181818",
        textName: "Arial-BoldMT",
        textSize: 14,
        lines: 1,
        lableBox: BoundBox(
            leading: 0,
            trailing: 0,
            top: 0,
            bottom: 0
        )
    )
    private lazy var lableThirdTime: UILabel = FrameThreeCollectionViewCell.makeLable(
        params:
            thirdLable
    )
    private let firstButtonImage = ImageDrawing.init(
        imageName: "bookmark",
        imageSize: CGSize(
            width: 16,
            height: 16
        ),
        radiusImage: 0
    )
    private let fistButtonSize = CGSize(
        width: 24,
        height: 24
    )
    private lazy var bookMarkButton: UIButton = FrameThreeCollectionViewCell.makeButtonBookmark(
        parameters:
            firstButtonImage,
        buttonSize:
            fistButtonSize
    )
    //MARK: - init(_:)
    override init(frame: CGRect) {
        
        super .init(frame: frame)
        self.contentView.addViews(views:
                                    foodImage,
                                  stackVertical,
                                  lableFirst,
                                  downViewForContent
        )
        self.contentView.addViewInStack(
            stack:
                stackVertical,
            views:
                foodImage,
            lableFirst,
            downViewForContent
        )
        
        downViewForContent.addViews(
            views:
                lableSecondTime,
            lableThirdTime,
            bookMarkButton
        )
    }
    
    //MARK: - Life Cycle
    override func layoutSubviews() {
        super.layoutSubviews()
        lableFirst.textAlignment = .center
        setupConstraints()
    }
    
    //MARK: - private funcs
    private func setupConstraints() {
        //stackVertView constraint (super stack)
        NSLayoutConstraint.activate([
            //set constraint stackVertical element
            stackVertical.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: stackParameters.offset.leading),
            stackVertical.topAnchor.constraint(equalTo: contentView.topAnchor, constant: stackParameters.offset.top),
            stackVertical.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: stackParameters.offset.trailing),
            stackVertical.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: stackParameters.offset.bottom),
            //set constraint foodImage element
            foodImage.widthAnchor.constraint(equalTo: foodImage.heightAnchor),
            foodImage.widthAnchor.constraint(equalToConstant: foodImageParameters.imageSize.width),
            foodImage.topAnchor.constraint(equalTo: stackVertical.topAnchor),
            foodImage.centerYAnchor.constraint(equalTo: stackVertical.centerYAnchor),
            foodImage.bottomAnchor.constraint(equalTo: stackVertical.topAnchor, constant: foodImageParameters.imageSize.height),
            foodImage.bottomAnchor.constraint(equalTo: lableFirst.topAnchor, constant: -firstLable.lableBox.top),
            //set constraint lableFirst element
            lableFirst.bottomAnchor.constraint(equalTo: downViewForContent.topAnchor, constant: -firstLable.lableBox.bottom),
            lableFirst.leadingAnchor.constraint(equalTo: stackVertical.leadingAnchor),
            lableFirst.trailingAnchor.constraint(equalTo: stackVertical.trailingAnchor),
            //set constraint downViewForContent element
            downViewForContent.leadingAnchor.constraint(equalTo: stackVertical.leadingAnchor),
            downViewForContent.trailingAnchor.constraint(equalTo: stackVertical.trailingAnchor),
            downViewForContent.bottomAnchor.constraint(equalTo: stackVertical.bottomAnchor),
            //set constraint lableSecondTime element
            lableSecondTime.topAnchor.constraint(equalTo: downViewForContent.topAnchor),
            lableSecondTime.leadingAnchor.constraint(equalTo: downViewForContent.leadingAnchor),
            //set constraint lableThirdTime element
            lableThirdTime.leadingAnchor.constraint(equalTo: downViewForContent.leadingAnchor),
            lableThirdTime.bottomAnchor.constraint(equalTo: downViewForContent.bottomAnchor),
            //set constraint bookMarkButton element
            bookMarkButton.widthAnchor.constraint(equalToConstant: fistButtonSize.width),
            bookMarkButton.widthAnchor.constraint(equalTo: bookMarkButton.heightAnchor),
            bookMarkButton.trailingAnchor.constraint(equalTo: downViewForContent.trailingAnchor),
            bookMarkButton.bottomAnchor.constraint(equalTo: downViewForContent.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Private extensions
private extension FrameThreeCollectionViewCell{
    
    static func makeStackVertical() -> UIStackView {
        let stackVerticalView = UIStackView()
        stackVerticalView.axis = .vertical
        stackVerticalView.alignment = .center
        stackVerticalView.backgroundColor = .clear
        stackVerticalView.translatesAutoresizingMaskIntoConstraints = false
        return stackVerticalView
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
    
    static func makeView() -> UIView {
        let downView = UIView()
        downView.backgroundColor = .clear
        return downView
    }
    
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
    
    static func makeButtonBookmark(parameters: ImageDrawing, buttonSize: CGSize) -> UIButton {
        let buttonBookmarkView = UIButton(type: .custom)
        buttonBookmarkView.frame.size = buttonSize
        buttonBookmarkView.backgroundColor = .clear
        let image = UIImage(named: parameters.imageName)
        let imageView = UIImageView()
        imageView.frame.size = parameters.imageSize
        imageView.image = image
        buttonBookmarkView.addSubview(imageView)
        imageView.contentMode = .center
        imageView.contentMode = .scaleAspectFit
        imageView.center = buttonBookmarkView.center
        buttonBookmarkView.translatesAutoresizingMaskIntoConstraints = false
        return buttonBookmarkView
    }
}


