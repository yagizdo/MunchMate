//
//  FoodDetailInteractor.swift
//  FoodDeliveryApp
//
//  Created by Yılmaz Yağız Dokumacı on 21.02.2023.
//

import Foundation

class FoodDetailInteractor : PresenterToInteractorFoodDetailProtocol {
    var foodDetailPresenter: InteractorToPresenterFoodDetailProtocol?
    
    func addFoodToCart(userMail: String, food: Yemekler, piece: Int?) {
        if piece == 0 {
            self.foodDetailPresenter?.sendDataToView(isSuccess: false)
        } else {
            NetworkService.shared.addFoodToCart(userMail: userMail, food: food, piece: piece) { isSuccess in
                self.foodDetailPresenter?.sendDataToView(isSuccess: true)
            } onFailure: { Error in
                self.foodDetailPresenter?.showError(error: Error)
            }
        }
    }
}
