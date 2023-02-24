//
//  FoodDetailRouter.swift
//  FoodDeliveryApp
//
//  Created by Yılmaz Yağız Dokumacı on 21.02.2023.
//

import Foundation

class FoodDetailRouter : PresenterToRouterFoodDetailProtocol {
    static func createModule(ref: FoodDetailViewController) {
        let presenter = FoodDetailPresenter()
        
        // View
        ref.foodDetailPresenterDelegate = presenter
        
        // Presenter
        ref.foodDetailPresenterDelegate?.foodDetailView = ref
        ref.foodDetailPresenterDelegate?.foodDetailInteractor = FoodDetailInteractor()
        
        // Interactor
        ref.foodDetailPresenterDelegate?.foodDetailInteractor?.foodDetailPresenter = presenter
    }
}
