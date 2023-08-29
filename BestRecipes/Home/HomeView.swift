//
//  HomeView.swift
//  BestRecipes
//
//  Created by Илья Шаповалов on 27.08.2023.
//

import UIKit

protocol HomeViewProtocol: UIView {
    var collectionView: UICollectionView { get }
    var searchBar: UISearchBar { get }
    
}

final class HomeView: UIView, HomeViewProtocol {
    
    //MARK: - Public properties
    let collectionView: UICollectionView = makeCollection()
    let label: UILabel = makeLabel()
    let searchBar: UISearchBar = makesearchBar()
    
    //MARK: - init(_:)
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        addSubview(collectionView)
        addSubview(label)
        addSubview(searchBar)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupConstraints()
        
        
    }
    
    
    //MARK: - Public methods
    
}

private extension HomeView {
    static func makeCollection() -> UICollectionView {
        
        let collection = UICollectionView(
            frame: .zero,
            collectionViewLayout: makeCollectionLayout()
        )
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }
    
    static func makeCollectionLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout(section: .copy())
        return layout
    }
    
    static func makeLabel() -> UILabel {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Get amazing reciepes for cooking"
        label.font = .boldSystemFont(ofSize: 24)
        label.numberOfLines = 2
        label.backgroundColor = .white
        label.textAlignment = .left
        return label
    }
    
    
    static func makesearchBar() -> UISearchBar {
       
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Search recipes"
        // text to left
        return searchBar
    }
    
    
  
    
    
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            // Label constraint
            label.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            label.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            label.heightAnchor.constraint(equalToConstant: 50),
            
            searchBar.topAnchor.constraint(equalTo: label.bottomAnchor),
            searchBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 44),
            
            collectionView.topAnchor.constraint(equalTo: searchBar.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            
        ])
        
        
        
    }
}
