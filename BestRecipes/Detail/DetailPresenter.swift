//
//  DetailPresenter.swift
//  BestRecipes
//
//  Created by Илья Шаповалов on 06.09.2023.
//

import Foundation
import OSLog

protocol DetailPresenterProtocol: AnyObject {
    func viewDidLoad()
    func viewDidDisappear()
}

protocol DetailPresenterDelegate: AnyObject {
    func recipeDidLoad(_ recipe: Recipe)
}

final class DetailPresenter: DetailPresenterProtocol {
    //MARK: - Private properties
    var recipe: Recipe
    
    
    //MARK: - Public properties
    weak var delegate: DetailPresenterDelegate?
    
    //MARK: - init(_:)
    init(recipe: Recipe) {
        self.recipe = recipe
        Logger.system.debug("DetailPresenter: \(#function)")
    }
    
    deinit {
        Logger.system.debug("DetailPresenter: \(#function)")
    }
    
    //MARK: - Public methods
    func viewDidLoad() {
        delegate?.recipeDidLoad(recipe)
    }
    
    func viewDidDisappear() {
        Logger.system.debug("DetailPresenter: \(#function)")
    }
}
