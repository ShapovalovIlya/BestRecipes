//
//  HomeView.swift
//  BestRecipes
//
//  Created by Илья Шаповалов on 27.08.2023.
//

import UIKit

protocol HomeViewProtocol: UIView {
    var collectionView: UICollectionView { get }
    
}

final class HomeView: UIView, HomeViewProtocol {
    
    //MARK: - Public properties
    let collectionView: UICollectionView = makeCollection()
    //
    let frameOne: TrendingRecipeCell = TrendingRecipeCell.init()
    
    //MARK: - init(_:)
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(collectionView)
        //
        addSubview(frameOne)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Public methods
    
}

private extension HomeView {
    static func makeCollection() -> UICollectionView {
        UICollectionView(frame: .zero, collectionViewLayout: .init())
    }
}
