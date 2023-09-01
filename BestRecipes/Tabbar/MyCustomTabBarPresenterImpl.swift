import UIKit

protocol MyCustomTabBarPresenter {
    func viewDidLoad()
}

class MyCustomTabBarPresenterImpl: MyCustomTabBarPresenter {
    
    private weak var view: MyCustomTabBarView?
    
    init(view: MyCustomTabBarView) {
        self.view = view
    }
    
    func viewDidLoad() {
        view?.setupSearchBar()
        view?.setupCustomTabBar()
        view?.addSomeTabItems()
        view?.configureMiddleButton()
    }
}

