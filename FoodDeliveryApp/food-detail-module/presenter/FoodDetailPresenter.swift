//
//  FoodDetailPresenter.swift
//  FoodDeliveryApp
//
//  Created by Yılmaz Yağız Dokumacı on 21.02.2023.
//

import Foundation

class FoodDetailPresenter : ViewToPresenterFoodDetailProtocol {
    var foodDetailInteractor: PresenterToInteractorFoodDetailProtocol?
    var foodDetailView: PresenterToViewFoodDetailProtocol?
    
    func addFoodToCart(userMail: String, food: Yemekler, piece: Int?) {
        foodDetailInteractor?.addFoodToCart(userMail: userMail, food: food, piece: piece)
    }
}

extension FoodDetailPresenter :  InteractorToPresenterFoodDetailProtocol {
    func sendDataToView(isSuccess: Bool) {
        foodDetailView?.sendDataToView(isSuccess: isSuccess)
    }
    
    func showError(error: Error) {
        foodDetailView?.showError(error: error)
    }
}
