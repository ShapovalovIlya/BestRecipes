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

final class HomeView: UIView, HomeViewProtocol, UISearchTextFieldDelegate {
    
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
            collectionViewLayout: makeCollectionViewLayout()
        )
        collection.register(RatedRecipeCell.self, forCellWithReuseIdentifier: RatedRecipeCell.cellId)
        collection.register(TitleSupplementaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView")
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .white
        
        return collection
    }
    
    static func makeCollectionLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
            
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            item.contentInsets = NSDirectionalEdgeInsets(
                top: 10,
                leading: 10,
                bottom: 10,
                trailing: 10
            )
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.85),
                heightDimension: .fractionalHeight(0.4)
            )
            
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitem: item,
                count: 1
            )
            
            
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            // to create spaces between sections
            section.contentInsets = NSDirectionalEdgeInsets(
                top: 10,
                leading: 10,
                bottom: 10,
                trailing: 10
            )
            
            
            
            return section
        }
        
        return layout
        
    }
    
    
    enum Section: Int, CaseIterable {
            case trending
            case popular
            case recent
            case creators
        }
    
    static func makeCollectionViewLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout {
            [self] sectionIndex, environment in
            
            
            switch Section(rawValue: sectionIndex) {
            case .trending, .popular, .creators, .recent:
                return self.makeGridLayoutSection()
            case nil:
                return nil
            }
        }
    }
    
    
    
    
   static func makeGridLayoutSection() -> NSCollectionLayoutSection {
        // Each item will take up half of the width of the group
        // that contains it, as well as the entire available height:
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        ))
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
       
        
        //Each group will then take up the entire available
        //width, and set its height to half of that width, to
        //make each item square-shaped:
       
       
       
       let groupSize = NSCollectionLayoutSize(
           widthDimension: .fractionalWidth(1),
           heightDimension: .fractionalHeight(0.4)
       )
       
       let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
       
//       let group = NSCollectionLayoutGroup.horizontal(
//           layoutSize: groupSize,
//           subitem: item,
//           count: 1
//       )
       
       
//        let group = NSCollectionLayoutGroup.horizontal(
//            layoutSize: NSCollectionLayoutSize(
//                widthDimension: .fractionalWidth(1),
//                heightDimension: .fractionalWidth(0.5)
//            ),
//            subitem: item,
//            count: 1
//        )
        let section = NSCollectionLayoutSection(group: group)
           section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0)
       section.orthogonalScrollingBehavior = .continuous

//           let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
//           let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
//           section.boundarySupplementaryItems = [sectionHeader]
           return section
    }
    
    
    
    static func makeLabel() -> UILabel {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Get amazing recipes for cooking"
        label.font = .boldSystemFont(ofSize: 28)
        label.numberOfLines = 0
        label.backgroundColor = .white
        label.textAlignment = .left
        return label
    }
    
    
    static func makesearchBar() -> UISearchBar {
        
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Search recipes"
        searchBar.spellCheckingType = .yes
        
        
        return searchBar
    }
    
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            // Label constraint
            label.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            label.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            label.heightAnchor.constraint(equalToConstant: 68),
            
            // searchBar constraint
            searchBar.topAnchor.constraint(equalTo: label.bottomAnchor),
            searchBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            searchBar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            searchBar.heightAnchor.constraint(equalToConstant: 64),
            
            // collectionView constraint
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            
        ])
        
        
        
    }
    
    
    
    
}

