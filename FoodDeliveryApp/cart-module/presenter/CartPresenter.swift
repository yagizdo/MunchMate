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
}

extension CartPresenter : InteractorToPresenterCartProtocol {
    func sendDataToView(cartFoods: [SepetYemekler]) {
        cartView?.sendDataToView(cartFoods: cartFoods)
    }
    
    func showError(error: Error) {
        cartView?.showError(error: error)
    }
}
