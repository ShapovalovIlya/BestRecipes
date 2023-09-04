//
//  NumberCell.swift
//  BestRecipes
//
//  Created by Леонид Турко on 30.08.2023.
//

import UIKit

final class NumberCell: UICollectionViewCell {
  
  lazy var textLabel: UILabel = {
    let element = UILabel()
    element.textColor = .black
    element.numberOfLines = 0
    element.font = .systemFont(ofSize: 20, weight: .bold)
    element.translatesAutoresizingMaskIntoConstraints = false
    return element
  }()
  
  private lazy var backImage: UIImageView = {
    let element = UIImageView()
    element.backgroundColor = .red
    element.translatesAutoresizingMaskIntoConstraints = false
    return element
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    addViews()
  }
  
  
  private func addViews() {
    addSubview(textLabel)
    addSubview(backImage)
    
    NSLayoutConstraint.activate([
      textLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      textLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
      
      backImage.topAnchor.constraint(equalTo: topAnchor),
      backImage.leadingAnchor.constraint(equalTo: leadingAnchor),
      backImage.widthAnchor.constraint(equalToConstant: 100),
      backImage.heightAnchor.constraint(equalTo: backImage.widthAnchor)

    ])
  }
  
  func configure(with recipe: Product) {
    backImage.image = UIImage(systemName: recipe.imageName)
    textLabel.text = recipe.name
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
