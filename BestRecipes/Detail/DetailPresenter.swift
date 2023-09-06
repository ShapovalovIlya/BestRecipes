//
//  DetailPresenter.swift
//  BestRecipes
//
//  Created by Илья Шаповалов on 06.09.2023.
//

import Foundation

protocol DetailPresenterProtocol: AnyObject {
    func viewDidLoad()
    func viewDidDisappear()
}

protocol DetailPresenterDelegate: AnyObject {
    
}

final class DetailPresenter: DetailPresenterProtocol {
    
    
    func viewDidLoad() {
        
    }
    
    func viewDidDisappear() {
        
    }
    
}
