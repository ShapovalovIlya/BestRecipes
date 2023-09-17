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
    private struct Drawing {
        static let contentOffset: CGFloat = 10
        static let searchBarHeight: CGFloat = 44
    }
    
    //MARK: - Private properties
    let titleLabel: UILabel = .makeLabel(
        font: .boldSystemFont(ofSize: 28),
        color: .black,
        numberOfLines: 2
    )
    
    //MARK: - Public properties
    let collectionView: UICollectionView = makeCollection()
    let searchBar: UISearchBar = makeSearchBar()
    
    //MARK: - init(_:)
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        addSubviews(
            titleLabel,
            searchBar,
            collectionView
        )
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.text = "Get amazing recipes for cooking"
        setupConstraints()
    }
    
    
    //MARK: - Public methods
    
    
}

private extension HomeView {
    //MARK: - Section
    enum Section: Int, CaseIterable {
        case trending
        case categoryButtons
        case categoryRecipes
        case recent
    }
    
    //MARK: - Private methods
    static func makeSearchBar() -> UISearchBar {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Search recipes"
        searchBar.spellCheckingType = .yes
        searchBar.barTintColor = .white
        searchBar.setBackgroundImage(.init(), for: .any, barMetrics: .default)
        return searchBar
    }
    
    static func makeCollection() -> UICollectionView {
        let collection = UICollectionView(
            frame: .zero,
            collectionViewLayout: makeCollectionViewLayout()
        )
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .white
        return collection
    }
    
    static func makeCollectionViewLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { sectionIndex, environment in
            switch Section(rawValue: sectionIndex) {
            case .trending:
                return makeTrendingLayoutSection()
                
            case .categoryButtons:
                return makeCategoriesButtonLayoutSection()
                
            case .categoryRecipes:
                return makeCategoryLayoutSection()
                
            case .recent:
                return makeRecentLayoutSection()
                
            case nil:
                return nil
            }
        }
    }
    
    static func makeTrendingLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.7),
            heightDimension: .fractionalHeight(0.4)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
        section.orthogonalScrollingBehavior = .continuous
        
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: .headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .topLeading
        )
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
    static func makeCategoriesButtonLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.23),
            heightDimension: .estimated(44)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 10, leading: 0, bottom: 10, trailing: 0)
        
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: .headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .topLeading
        )
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
    static func makeCategoryLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.4),
            heightDimension: .fractionalHeight(0.37)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    static func makeRecentLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.35),
            heightDimension: .fractionalHeight(0.27)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
        section.orthogonalScrollingBehavior = .continuous
        
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: .headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .topLeading
        )
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            // Label constraint
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: Drawing.contentOffset),
            titleLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 68),
            // searchBar constraint
            searchBar.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            searchBar.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            searchBar.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: Drawing.searchBarHeight),
            // collectionView constraint
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

