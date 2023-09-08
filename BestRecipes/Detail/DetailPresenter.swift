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
    private let apiClient: ApiClientProtocol
    
    //MARK: - Public properties
    weak var delegate: DetailPresenterDelegate?
    
    //MARK: - init(_:)
    init(apiClient: ApiClientProtocol) {
        self.apiClient = apiClient
        
        Logger.system.debug("DetailPresenter: \(#function)")
    }
    
    deinit {
        Logger.system.debug("DetailPresenter: \(#function)")
    }
    
    //MARK: - Public methods
    func viewDidLoad() {
        Logger.system.debug("DetailPresenter: \(#function)")
    }
    
    func viewDidDisappear() {
        Logger.system.debug("DetailPresenter: \(#function)")
    }
    
}
