//
//  CartPresenter.swift
//  FoodDeliveryApp
//
//  Created by Yılmaz Yağız Dokumacı on 22.02.2023.
//

import Foundation

class CartPresenter : ViewToPresenterCartProtocol {
    var cartView: PresenterToViewCartProtocol?
    var cartInteractor: PresenterToInteractorCartProtocol?
    
    func getAllCartItems() {
        cartInteractor?.getAllCartItems()
    }
    
    func removeFoodFromCart(food_id: Int, userMail: String) {
        cartInteractor?.removeFoodFromCart(food_id: food_id, userMail: userMail)
    }
}

extension CartPresenter : InteractorToPresenterCartProtocol {
    func sendDataToView(cartFoods: [SepetYemekler]) {
        cartView?.sendDataToView(cartFoods: cartFoods)
    }
    
    func sendDataToView(isSuccess: Bool) {
        cartView?.sendDataToView(isSuccess: isSuccess)
    }
    
    func showError(error: Error) {
        cartView?.showError(error: error)
    }
}
