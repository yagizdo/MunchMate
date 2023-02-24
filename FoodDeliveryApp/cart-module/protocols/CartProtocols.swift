//
//  CartProtocols.swift
//  FoodDeliveryApp
//
//  Created by Yılmaz Yağız Dokumacı on 22.02.2023.
//

import Foundation

protocol ViewToPresenterCartProtocol {
    var cartView : PresenterToViewCartProtocol? {get set}
    var cartInteractor : PresenterToInteractorCartProtocol? {get set}
    
    func getAllCartItems()
    func removeFoodFromCart(food_id: Int, userMail: String)
}

protocol PresenterToInteractorCartProtocol {
    var cartPresenter : InteractorToPresenterCartProtocol? {get set}
    
    func getAllCartItems()
    func removeFoodFromCart(food_id: Int, userMail: String)
}

protocol InteractorToPresenterCartProtocol {
    func sendDataToView(cartFoods:[SepetYemekler])
    func sendDataToView(isSuccess:Bool)
    func showError(error:Error)
}

protocol PresenterToViewCartProtocol {
    func sendDataToView(cartFoods:[SepetYemekler])
    func sendDataToView(isSuccess:Bool)
    func showError(error:Error)
}

// Router Protocol
protocol PresenterToRouterCartProtocol {
    static func createModule(ref:CartViewController)
}
