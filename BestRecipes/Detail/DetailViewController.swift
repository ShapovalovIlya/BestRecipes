//
//  DetailViewController.swift
//  BestRecipes
//
//  Created by Леонид Турко on 30.08.2023.
//

import UIKit
import OSLog

final class DetailViewController: UIViewController {
    //MARK: - Private properties
    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: DetailViewController.self)
    )
    private let detailView: DetailViewProtocol
    private lazy var dataSource = makeDataSource()
    
    let list = ProductList()
    
    // MARK: - init(_:)
    init(detailView: DetailViewProtocol) {
        self.detailView = detailView
        super.init(nibName: nil, bundle: nil)
        
        logger.debug("Initialized")
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - deinit
    deinit {
        logger.debug("Deinitialized")
    }
    
    //  MARK: - Life Cycle
    override func loadView() {
        self.view = detailView
        
        logger.debug("Load view")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource.supplementaryViewProvider = makeHeaderRegistration().headerProvider
        detailView.collectionView.dataSource = dataSource
        
        productListDidLoad(list)
        
        logger.debug("View did load")
    }
    
}

private extension DetailViewController {
    enum Section: Int, CaseIterable {
        case main
        case additional
        case all
    }
    
    //MARK: - Typealias
    typealias Cell = NumberCell
    typealias Header = TitleSupplementaryView
    typealias CellRegistration = UICollectionView.CellRegistration<Cell, Product>
    typealias HeaderRegistration = UICollectionView.SupplementaryRegistration<Header>
    
    //MARK: - Private methods
    func productListDidLoad(_ list: ProductList) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Product>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(list.featured, toSection: .main)
        snapshot.appendItems(list.onSale, toSection: .additional)
        snapshot.appendItems(list.all, toSection: .all)
        
        dataSource.apply(snapshot)
    }
    
    func makeDataSource() -> UICollectionViewDiffableDataSource<Section, Product> {
        UICollectionViewDiffableDataSource(
            collectionView: detailView.collectionView,
            cellProvider: makeCellRegistration().cellProvider
        )
    }
    
    func makeCellRegistration() -> CellRegistration {
        CellRegistration { cell, indexPath, product in
            cell.configure(with: product)
            cell.backgroundColor = .systemPink
        }
    }
    
    func makeHeaderRegistration() -> HeaderRegistration {
        .init(elementKind: UICollectionView.elementKindSectionHeader) { supplementaryView, elementKind, indexPath in
            let tutorialCollection = ["How to cook", "Instructions", "Ingredients"]
            
            switch Section(rawValue: indexPath.section) {
            case .main:
                supplementaryView.textLabel.text = tutorialCollection[indexPath.section]
                
            case .additional:
                supplementaryView.textLabel.text = tutorialCollection[indexPath.section]
                
            case .all:
                supplementaryView.textLabel.text = tutorialCollection[indexPath.section]
                supplementaryView.numberLabel.text = "\(tutorialCollection.count) items"
                
            case nil:
                break
            }
        }
    }
    
}

private extension UICollectionView.CellRegistration {
    var cellProvider: (UICollectionView, IndexPath, Item) -> Cell {
        return { collectionView, indexPath, product in
            collectionView.dequeueConfiguredReusableCell(
                using: self,
                for: indexPath,
                item: product
            )
        }
    }
}

private extension UICollectionView.SupplementaryRegistration<TitleSupplementaryView> {
    var headerProvider: (UICollectionView, String, IndexPath) -> TitleSupplementaryView {
        return { collectionView, kind, indexPath in
            collectionView.dequeueConfiguredReusableSupplementary(
                using: self,
                for: indexPath
            )
        }
    }
}

//  MARK: - Show Canvas
import SwiftUI

struct ContentViewController: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = DetailViewController
    
    func makeUIViewController(context: Context) -> UIViewControllerType {
        return DetailViewController(detailView: DetailView())
    }
    
    func updateUIViewController(_ uiViewController: DetailViewController, context: Context) {}
}

struct ContentViewController_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewController()
            .edgesIgnoringSafeArea(.all)
            .colorScheme(.light) // or .dark
    }
}
