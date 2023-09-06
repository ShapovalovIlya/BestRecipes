//
//  FrameTwoCollectionViewCell.swift
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

final class FrameTwoCollectionViewCell: UICollectionViewCell {
    //MARK: - Private lets and vars
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
    private let stackVertical = FrameTwoCollectionViewCell.makeStackVertical()
    private let stackVerticalInfo = FrameTwoCollectionViewCell.makeStackInfoVertical()
    private let foodImageParameters = ImageDrawing(
        imageName: "foodPhoto",
        imageSize: CGSize(
            width: 124,
            height: 124
        ),
        radiusImage: 12
    )
    private lazy var foodImage: UIImageView = FrameTwoCollectionViewCell.makeImageFood(
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
    private lazy var lableFirstInfo: UILabel = FrameTwoCollectionViewCell.makeLable(
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
    private lazy var lableSecondInfo: UILabel = FrameTwoCollectionViewCell.makeLable(params: textSecondInfoLable)
    
    //MARK: - init(_:)
    override init(frame: CGRect) {
        super .init(frame: frame)
        self.backgroundColor = .gray
        self.contentView.addViews(
            views:
                foodImage,
            stackVertical,
            stackVerticalInfo,
            lableFirstInfo,
            lableSecondInfo
        )
        self.contentView.addViewInStack(
            stack:
                stackVertical,
            views:
                foodImage,
            stackVerticalInfo
        )
        addViewInStack(
            stack:
                stackVerticalInfo,
            views:
                lableFirstInfo,
            lableSecondInfo
        )
    }
    //MARK: - Life Cycle
    override func layoutSubviews() {
        super.layoutSubviews()
        stackVerticalInfo.spacing = (self.frame.height*scaleData.stackSpacing)
        setupConstraints()
    }
    //MARK: - private funcs
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            //set constraint stackImage element
            stackVertical.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: stackParameters.offset.leading),
            stackVertical.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: stackParameters.offset.top),
            stackVertical.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: stackParameters.offset.trailing),
            stackVertical.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: stackParameters.offset.bottom),
            //set constraint foodImage element
            foodImage.widthAnchor.constraint(equalToConstant: foodImageParameters.imageSize.width),
            foodImage.heightAnchor.constraint(equalToConstant: foodImageParameters.imageSize.height),
            foodImage.leadingAnchor.constraint(equalTo: stackVertical.leadingAnchor),
            foodImage.topAnchor.constraint(equalTo: stackVertical.topAnchor),
            foodImage.trailingAnchor.constraint(equalTo: stackVertical.trailingAnchor),
            //set constraint stackVerticalInfo element
            stackVerticalInfo.leadingAnchor.constraint(equalTo: stackVertical.leadingAnchor),
            stackVerticalInfo.bottomAnchor.constraint(equalTo: stackVertical.bottomAnchor),
            stackVerticalInfo.topAnchor.constraint(equalTo: foodImage.bottomAnchor),
            stackVerticalInfo.trailingAnchor.constraint(equalTo: stackVertical.trailingAnchor, constant: (stackParameters.offset.trailing*scaleData.stackTrailing)),
            //set constraint lableFirstInfo element
            lableFirstInfo.heightAnchor.constraint(equalToConstant: self.contentView.frame.height*scaleData.lableFirstHeigth),
            lableFirstInfo.leadingAnchor.constraint(equalTo: stackVerticalInfo.leadingAnchor),
            lableFirstInfo.topAnchor.constraint(equalTo: stackVerticalInfo.topAnchor),
            lableFirstInfo.trailingAnchor.constraint(equalTo: stackVerticalInfo.trailingAnchor),
            //set constraint lableSecondInfo element
            lableSecondInfo.leadingAnchor.constraint(equalTo: stackVerticalInfo.leadingAnchor),
            lableSecondInfo.bottomAnchor.constraint(equalTo: stackVerticalInfo.bottomAnchor),
            lableSecondInfo.trailingAnchor.constraint(equalTo: stackVerticalInfo.trailingAnchor),
            lableSecondInfo.heightAnchor.constraint(equalToConstant: (self.contentView.frame.height*scaleData.lableSecondHeigth)),
        ])}
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Public extensions
extension UIView {
    //add all views
    func addViews(
        views: UIView...
    ) {
        for view in views {
            self.addSubview(view)
        }
    }
    //add views in stack
    func addViewInStack(
        stack: UIStackView,
        views: UIView...
    ) {
        for view in views {
            stack.addArrangedSubview(view)
        }
    }
}

//MARK: - Private extensions
private extension FrameTwoCollectionViewCell{
    
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
