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
    
    func removeFoodFromCart(food_name: String, userMail: String) {
        cartInteractor?.removeFoodFromCart(food_name: food_name, userMail: userMail)
    }
}

extension CartPresenter : InteractorToPresenterCartProtocol {
    func sendDataToView(cartFoods: [CartFoodItem]) {
        cartView?.sendDataToView(cartFoods: cartFoods)
    }
    
    func sendDataToView(isSuccess: Bool) {
        cartView?.sendDataToView(isSuccess: isSuccess)
    }
    
    func showError(error: Error) {
        cartView?.showError(error: error)
    }
}
