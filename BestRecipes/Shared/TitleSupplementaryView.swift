//
//  TitleSupplementaryView.swift
//  BestRecipes
//
//  Created by Эльдар Ахатов on 06/09/23.
//

import Foundation
import UIKit


class TitleSupplementaryView: UICollectionReusableView {
    
    static let reuseIdentifier = String(describing: TitleSupplementaryView.self)
    
    let seeAllButton = UIButton(type: .system)
    let textLabel = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupElements()
        setupHeaderView()
        
      
      }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
      override func prepareForReuse() {
        super.prepareForReuse()
        textLabel.text = nil
       
        
      }
    
    
    func setupElements() {
        
        addSubview(seeAllButton)
        addSubview(textLabel)
        
        seeAllButton.titleLabel?.text = "See all ->"
        seeAllButton.titleLabel?.textColor = .red
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        seeAllButton.translatesAutoresizingMaskIntoConstraints = false

    }
    
    func setupHeaderView() {
        
        NSLayoutConstraint.activate([
            
            // button constraints
            seeAllButton.topAnchor.constraint(equalTo: topAnchor),
//            seeAllButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            seeAllButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            seeAllButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            
            // label constraints
            textLabel.topAnchor.constraint(equalTo: topAnchor),
            textLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            textLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            textLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
            
        
        ])
    }
    
}
