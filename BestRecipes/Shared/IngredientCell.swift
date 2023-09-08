//
//  IngredientCell.swift
//  BestRecipes
//
//  Created by Dmitriy Eliseev on 06.09.2023.
//

import UIKit

final class IngredientCell: UICollectionViewCell {
    
//    private let ingredientImage: UIImageView = makeImageView()
    //MARK: - static let
    static let stackParameters = StackDrawing(
        offset:
            BoundBox(
                leading: 20,
                trailing: 0,
                top: 0,
                bottom: 0
            ),
        spacing: 16
    )
    //MARK: - private lets
    private let initData = initDataCollectionViewCell(
        cornerRadius: 16,
        color: UIColor(
            hex: "f1f1f1"
        ) ?? .gray
    )
    private let scaleLables = ScaleFactorLables.init(lableFirst: 0.55, lableSecond: 0.11)
    private let stackHorisontal = IngredientCell.makeStack(
        stackBoundBox: stackParameters
    )
    private let foodImageParameters = ImageDrawing(
        imageName: "fish",
        imageSize: CGSize(
            width: 52,
            height: 52
        ),
        radiusImage: 8
    )
    private lazy var foodImage: UIImageView = IngredientCell.makeImageFood(
        parameters: foodImageParameters
    )
    private let firstLable = TextParameters(
        text: "Fish",
        colorHex: "181818",
        textName: "Arial-BoldMT",
        textSize: 18,
        lines: 1,
        lableBox: BoundBox(
            leading: 0,
            trailing: 0,
            top: 0,
            bottom: 0
        )
    )
    private lazy var lableFirst: UILabel = IngredientCell.makeLable(
        params: firstLable
    )
    private let secondLable = TextParameters(
        text: "200g",
        colorHex: "919191",
        textName: "ArialMT",
        textSize: 18,
        lines: 1,
        lableBox: BoundBox(
            leading: 0,
            trailing: 20,
            top: 0,
            bottom: 0
        )
    )
    private lazy var lableSecond: UILabel = IngredientCell.makeLable(
        params: secondLable
    )
    
    //MARK: - init(_:)
    override init(frame: CGRect) {
        super.init(frame: CGRect(
            x: Drawing.mainView.origin.x,
            y:Drawing.mainView.origin.y,
            width: Drawing.mainView.size.width,
            height: Drawing.mainView.size.height)
        )
        setSettings()
        self.contentView.addSubviews(
                stackHorisontal,
            foodImage,
            lableFirst,
            lableSecond
        )
        
        stackHorisontal.addArrangedSubviews(
            foodImage,
            lableFirst,
            lableSecond
        )
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life Cycle
    override func layoutSubviews() {
        super.layoutSubviews()
        lableFirst.adjustsFontSizeToFitWidth = true
        setupConstraints()
    }
    
    //MARK: - private funcs
    private func setSettings(){
        self.contentView.backgroundColor = initData.color
        self.contentView.layer.cornerRadius = initData.cornerRadius
        self.contentView.clipsToBounds = true
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackHorisontal.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            stackHorisontal.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -secondLable.lableBox.trailing),
            stackHorisontal.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            stackHorisontal.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            foodImage.widthAnchor.constraint(equalToConstant: foodImageParameters.imageSize.width),
            foodImage.heightAnchor.constraint(equalToConstant: foodImageParameters.imageSize.height),
            foodImage.leadingAnchor.constraint(equalTo: stackHorisontal.leadingAnchor, constant: IngredientCell.stackParameters.offset.leading),
            lableFirst.widthAnchor.constraint(equalToConstant: self.contentView.frame.width*scaleLables.lableFirst),
            lableSecond.widthAnchor.constraint(equalToConstant: self.contentView.frame.width*scaleLables.lableSecond)
        ])
    }
}

//MARK: - Public extensions
extension IngredientCell {
    private enum Drawing{
        case mainView
        var origin: CGPoint{
            switch self {
            case .mainView:
                return .init(x: 10, y: 100)
            }
        }
        var size: CGSize{
            switch self {
            case .mainView:
                return .init(width: 343, height: 76)//343 76
                
            }
        }
    }
}

private extension IngredientCell {
    static func makeStack(stackBoundBox: StackDrawing) -> UIStackView {
        let stackHorizontalView = UIStackView()
        stackHorizontalView.axis = .horizontal
        stackHorizontalView.distribution = .fill
        stackHorizontalView.spacing = stackBoundBox.spacing
        stackHorizontalView.alignment = .center
        stackHorizontalView.backgroundColor = .clear
        stackHorizontalView.translatesAutoresizingMaskIntoConstraints = false
        return stackHorizontalView
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
private struct ScaleFactorLables {
    var lableFirst: CGFloat
    var lableSecond: CGFloat
}

private struct initDataCollectionViewCell{
    var cornerRadius: CGFloat
    var color: UIColor
}
