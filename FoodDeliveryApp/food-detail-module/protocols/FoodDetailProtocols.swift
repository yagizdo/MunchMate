//
//  FoodDetailProtocols.swift
//  FoodDeliveryApp
//
//  Created by Yılmaz Yağız Dokumacı on 21.02.2023.
//

import Foundation

protocol ViewToPresenterFoodDetailProtocol {
    
    var foodDetailInteractor : PresenterToInteractorFoodDetailProtocol? {get set}
    var foodDetailView : PresenterToViewFoodDetailProtocol? {get set}
    
    func addFoodToCart(userMail:String, food:Yemekler,piece:Int?)
    
}

protocol PresenterToInteractorFoodDetailProtocol {
    
    var foodDetailPresenter : InteractorToPresenterFoodDetailProtocol? {get set}
    
    func addFoodToCart(userMail:String, food:Yemekler,piece:Int?)
}


protocol InteractorToPresenterFoodDetailProtocol {
    func sendDataToView(isSuccess:Bool)
    func showError(error:Error)
}

protocol PresenterToViewFoodDetailProtocol {
    func sendDataToView(isSuccess:Bool)
    func showError(error:Error)
}



// Router Protocol
protocol PresenterToRouterFoodDetailProtocol {
    static func createModule(ref:FoodDetailViewController)
}
