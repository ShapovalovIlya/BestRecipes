//
//  LoadingView.swift
//  BestRecipes
//
//  Created by Леонид Турко on 09.09.2023.
//

import UIKit

final class LoadingView: UIView {
  private let activityIndicator = UIActivityIndicatorView(style: .large)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
    activityIndicator.startAnimating()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  deinit {
    activityIndicator.stopAnimating()
  }
}

extension LoadingView {
  private func setup() {
    backgroundColor = UIColor(white: 0, alpha: 0.5)
    
    addSubview(activityIndicator)
    activityIndicator.color = .white
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
      activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
    ])
  }
  
  func startAnimating() {
    activityIndicator.startAnimating()
    isHidden = false
  }
  
  func stopAnimating() {
    activityIndicator.stopAnimating()
    isHidden = true
  }
}

