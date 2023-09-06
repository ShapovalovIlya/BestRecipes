//
//  FrameOneCollectionViewCell.swift
//  BestRecipes
//
//  Created by Dmitriy Eliseev on 06.09.2023.
//

import UIKit

final class FrameOneCollectionViewCell: UICollectionViewCell {
    private let stackParameters = StackDrawing(
        offset:
            BoundBox(
                leading: 10,
                trailing: -10,
                top: 10,
                bottom: -10),
        spacing: 10
    )
    private let stackVertical = FrameOneCollectionViewCell.makeStackVertical()
    private let stackTitle = FrameOneCollectionViewCell.makeStackHorisontal()
    private let mediaImageParameters = ImageDrawing(
        imageName: "test_img",
        imageSize: CGSize(
            width: 280,
            height: 180
        ),
        radiusImage: 8
    )
    private lazy var media: UIImageView = FrameOneCollectionViewCell.makeImage(
        parameters: mediaImageParameters
    )

    private let textTitleParameters = TextParameters(
        text: "How to sharwama at home",
        colorHex: "181818",
        textName: "Arial-BoldMT",
        textSize: 16,
        lines: 1,
        lableBox: BoundBox(
            leading: 0,
            trailing: 0,
            top: 0,
            bottom: 0
        )
    )
    private lazy var titleLable = FrameOneCollectionViewCell.makeLable(
        params: textTitleParameters
    )
    private let stackCreator = FrameOneCollectionViewCell.makeStackHorisontal()
    private let creatorImageName = ImageDrawing(
        imageName: "creator",
        imageSize: CGSize(
            width: 32,
            height: 32
        ),
        radiusImage: 32/2
    )
    private lazy var creatorImage = FrameOneCollectionViewCell.makeImage(
        parameters: creatorImageName
    )
    private let buttonParameters = ImageDrawing(
        imageName: "burgerBtn.png",
        imageSize: CGSize(
            width: 20,
            height: 20
        ),
        radiusImage: 0
    )
    private lazy var buttonTitle = FrameOneCollectionViewCell.makeButtonTitle(
        parameters: buttonParameters
    )
    private let textCreatorParameters = TextParameters(
        text: "By Zeelicious foods",
        colorHex: "919191",
        textName: "ArialMT",
        textSize: 12,
        lines: 1,
        lableBox: BoundBox(
            leading: 0,
            trailing: 0,
            top: 8,
            bottom: 8
        )
    )
    private lazy var creatorLable = FrameOneCollectionViewCell.makeLable(
        params: textCreatorParameters
    )
    private let firstButtonImage = ImageDrawing.init(
        imageName: "bookmark",
        imageSize: CGSize(
            width: 21.33,
            height: 21.33
        ),
        radiusImage: 0
    )
    private let fistButtonSize = CGSize(
        width: 32,
        height: 32
    )
    private lazy var buttonBookmark = FrameOneCollectionViewCell.makeButtonBookmark(
        parameters:
            firstButtonImage,
        buttonSize:
            fistButtonSize
    )
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
    private lazy var raiting = FrameOneCollectionViewCell.makeButtonRaiting(
        parameters:
            raitingButton
    )
   
    //MARK: - init(_:)
    override init(frame: CGRect) {
        super .init(frame: frame)
        self.backgroundColor = .clear
        self.contentView.addViews(views:
                                stackVertical,
                                  media,
                                  stackTitle,
                                  titleLable,
                                  buttonTitle,
                                  stackCreator,
                                  creatorImage,
                                  creatorLable,
                                  buttonBookmark,
                                  raiting
        )
        addViewInStack(
            stack: stackVertical,
            views: media,
            stackTitle,
            stackCreator
        )
        addViewInStack(
            stack:stackTitle,
            views: titleLable, buttonTitle
        )
        addViewInStack(
            stack: stackCreator,
            views: creatorImage, creatorLable
        )
    }

    //MARK: - Life Cycle
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    
    //MARK: - private funcs
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackVertical.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: stackParameters.offset.leading),
            stackVertical.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: stackParameters.offset.top),
            stackVertical.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: stackParameters.offset.trailing),
            stackVertical.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: stackParameters.offset.bottom),
            media.leadingAnchor.constraint(equalTo: stackVertical.leadingAnchor),
            media.topAnchor.constraint(equalTo: stackVertical.topAnchor),
            media.trailingAnchor.constraint(equalTo: stackVertical.trailingAnchor),
            media.heightAnchor.constraint(equalToConstant: mediaImageParameters.imageSize.height),
            stackTitle.leadingAnchor.constraint(equalTo: stackVertical.leadingAnchor),
            stackTitle.trailingAnchor.constraint(equalTo: stackVertical.trailingAnchor),
            buttonTitle.heightAnchor.constraint(equalTo: buttonTitle.widthAnchor),
            buttonTitle.heightAnchor.constraint(equalToConstant: buttonParameters.imageSize.height),
            buttonTitle.trailingAnchor.constraint(equalTo: stackTitle.trailingAnchor),
            stackCreator.leadingAnchor.constraint(equalTo: stackVertical.leadingAnchor),
            stackCreator.heightAnchor.constraint(equalToConstant: creatorImageName.imageSize.height),
            stackCreator.trailingAnchor.constraint(equalTo: stackVertical.trailingAnchor, constant: -10),
            creatorImage.heightAnchor.constraint(equalTo: creatorImage.widthAnchor),
            creatorLable.leadingAnchor.constraint(equalTo: creatorImage.trailingAnchor, constant: 10),
            buttonBookmark.topAnchor.constraint(equalTo: stackVertical.topAnchor, constant: 8),
            buttonBookmark.trailingAnchor.constraint(equalTo: stackVertical.trailingAnchor, constant: -8),
            buttonBookmark.heightAnchor.constraint(equalTo: buttonBookmark.widthAnchor),
            buttonBookmark.heightAnchor.constraint(equalToConstant: fistButtonSize.height),
            raiting.leadingAnchor.constraint(equalTo: stackVertical.leadingAnchor, constant: 10),
            raiting.topAnchor.constraint(equalTo: stackVertical.topAnchor, constant: 10),
            raiting.widthAnchor.constraint(equalToConstant: raitingButton.buttonSize.width),
            raiting.heightAnchor.constraint(equalToConstant: raitingButton.buttonSize.height)
        ])}
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension FrameOneCollectionViewCell{
    static func makeStackVertical() -> UIStackView {
        let stackVerticalView = UIStackView()
        stackVerticalView.axis = .vertical
        stackVerticalView.alignment = .center
        stackVerticalView.backgroundColor = .clear
        stackVerticalView.translatesAutoresizingMaskIntoConstraints = false
        return stackVerticalView
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
    static func makeImage(parameters: ImageDrawing) -> UIImageView {
        let mediaImageView = UIImageView()
        mediaImageView.frame.size = parameters.imageSize
        mediaImageView.image = UIImage(named: parameters.imageName)
        mediaImageView.layer.cornerRadius = parameters.radiusImage
        mediaImageView.clipsToBounds = true
        mediaImageView.translatesAutoresizingMaskIntoConstraints = false
        return mediaImageView
    }
    static func makeStackHorisontal() -> UIStackView {
        let stackHorizontalView = UIStackView()
        stackHorizontalView.axis = .horizontal
        stackHorizontalView.distribution = .equalCentering
        stackHorizontalView.alignment = .center
        stackHorizontalView.backgroundColor = .clear
        stackHorizontalView.translatesAutoresizingMaskIntoConstraints = false
        return stackHorizontalView
    }
    static func makeButtonTitle(parameters: ImageDrawing) -> UIButton {
        var btnConf = UIButton.Configuration.plain()
        let testImage = UIImage(named: parameters.imageName)
        btnConf.image = testImage
        let buttonTitleView = UIButton(configuration: btnConf)
        buttonTitleView.imageView?.contentMode = .scaleAspectFit
        buttonTitleView.contentMode = .scaleAspectFill
        buttonTitleView.backgroundColor = .white
        buttonTitleView.frame.size = parameters.imageSize
        buttonTitleView.imageView?.frame = buttonTitleView.frame
        buttonTitleView.translatesAutoresizingMaskIntoConstraints = false
        return buttonTitleView
    }
    static func makeButtonBookmark(parameters: ImageDrawing, buttonSize: CGSize) -> UIButton {
        let buttonBookmarkView = UIButton(type: .custom)
        buttonBookmarkView.frame.size = buttonSize
        buttonBookmarkView.backgroundColor = .white
        buttonBookmarkView.layer.cornerRadius = buttonBookmarkView.frame.height/2
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
