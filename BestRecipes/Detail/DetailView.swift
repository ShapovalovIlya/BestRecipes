//
//  DetailView.swift
//  BestRecipes
//
//  Created by Леонид Турко on 04.09.2023.
//

import UIKit

protocol DetailViewProtocol: UIView {
    var collectionView: UICollectionView { get }
    var titleLabel: UILabel { get }
}

final class DetailView: UIView, DetailViewProtocol {
    let titleLabel: UILabel = .makeLabel(
        font: .titleHeading,
        color: .black,
        numberOfLines: 2
    )
    let collectionView: UICollectionView = makeCollectionView()
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        addSubviews(
            titleLabel,
            collectionView
        )
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //  MARK: - Life Cycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setConstraints()
    }
}

//  MARK: -  Private Methods
private extension DetailView {
    enum Section: Int, CaseIterable {
        case title
        case summary
        case list
    }
    
    static func makeCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: makeCollectionViewLayout()
        )
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }
    
    static func makeCollectionViewLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { sectionIndex, environment in
            switch Section(rawValue: sectionIndex) {
            case .title:
                return makeTitleLayoutSection()
                
            case .summary:
                return makeSummaryLayoutSection()
                
            case .list:
                return makeListLayoutSection()
                
            case nil:
                return nil
            }
        }
    }
    
    static func makeTitleLayoutSection() -> NSCollectionLayoutSection {
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
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(0.45)
            ),
            subitem: item,
            count: 1
        )
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    static func makeSummaryLayoutSection() -> NSCollectionLayoutSection {
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
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(0.5)
            ),
            subitem: item,
            count: 1
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0)
        
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: .headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .topLeading)
        
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
    static func makeListLayoutSection() -> NSCollectionLayoutSection {
        // Here, each item completely fills its parent group:
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        ))
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        // Each group then contains just a single item, and fills
        // the entire available width, while defining a fixed
        // height of 50 points:
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(0.15)
            ),
            subitems: [item]
        )
        group.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
        let section = NSCollectionLayoutSection(group: group)
        
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0)
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(44)
        )
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .topLeading
        )
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 10),
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            titleLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -10),
            titleLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1),
            
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            collectionView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
