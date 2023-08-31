//
//  NumberCell.swift
//  BestRecipes
//
//  Created by Леонид Турко on 30.08.2023.
//

import UIKit

class NumberCell: UICollectionViewCell {
  static let reuseIdentifier = String(describing: NumberCell.self)
  
  //@IBOutlet weak var label: UILabel!
  
  lazy var nameLabel: UILabel = {
    let element = UILabel()
    element.textColor = .black
    element.font = .systemFont(ofSize: 40, weight: .bold)
    element.translatesAutoresizingMaskIntoConstraints = false
    return element
  }()
  
  private lazy var image: UIImageView = {
    let element = UIImageView()
    element.image = UIImage(systemName: "cloud")
    return element
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    addViews()
  }
  
  
  private func addViews() {
    addSubview(nameLabel)
    
    NSLayoutConstraint.activate([
      nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
      nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
