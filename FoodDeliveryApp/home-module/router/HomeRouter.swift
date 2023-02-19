//
//  HomeRouter.swift
//  FoodDeliveryApp
//
//  Created by Yılmaz Yağız Dokumacı on 12.02.2023.
//

import Foundation

class HomeRouter : PresenterToRouterHomeProtocol {
    static func createModule(ref: HomeViewController) {
        
        let presenter = HomePresenter()
        
        // View
        ref.homePresenterDelegate = presenter
        
        // Presenter
        ref.homePresenterDelegate?.homeView = ref
        ref.homePresenterDelegate?.homeInteractor = HomeInteractor()
        
        // Interactor
        ref.homePresenterDelegate?.homeInteractor?.homePresenter = presenter
    }
}
