//
//  CartInteractor.swift
//  FoodDeliveryApp
//
//  Created by Yılmaz Yağız Dokumacı on 22.02.2023.
//

import Foundation

class CartInteractor : PresenterToInteractorCartProtocol {
    
    var cartPresenter: InteractorToPresenterCartProtocol?
    
    var networkService:NetworkService?
    var authService : AuthService?
    
    init() {
        networkService = NetworkService.shared
        authService = AuthService.shared
    }
    
    func getAllCartItems() {
        if let userEmail = authService?.currentUser?.email {
            networkService?.getCartItems(userMail: userEmail, onSuccess: { cartFoods in
                self.cartPresenter?.sendDataToView(cartFoods: cartFoods)
            }, onFailure: { error in
                self.cartPresenter?.showError(error: error)
            })
        }
    }
}
