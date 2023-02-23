//
//  CartRouter.swift
//  FoodDeliveryApp
//
//  Created by Yılmaz Yağız Dokumacı on 22.02.2023.
//

import Foundation

class CartRouter : PresenterToRouterCartProtocol {
    static func createModule(ref: CartViewController) {
        
        let presenter = CartPresenter()
        
        // View
        ref.cartPresenterDelegate = presenter
        
        // Presenter
        ref.cartPresenterDelegate?.cartView = ref
        ref.cartPresenterDelegate?.cartInteractor = CartInteractor()
        
        // Interactor
        ref.cartPresenterDelegate?.cartInteractor?.cartPresenter = presenter
    }
}
