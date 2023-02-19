//
//  HomeProtocols.swift
//  FoodDeliveryApp
//
//  Created by Yılmaz Yağız Dokumacı on 12.02.2023.
//

import Foundation

protocol ViewToPresenterHomeProtocol {
   
    var homeInteractor : PresenterToInteractorHomeProtocol? {get set}
    var homeView : PresenterToViewHomeProtocol? {get set}
    
    func getAllFoods()
}

protocol PresenterToInteractorHomeProtocol {
    var homePresenter : InteractorToPresenterHomeProtocol? {get set}
    
    func getAllFoods()
}

protocol InteractorToPresenterHomeProtocol {
    func sendDataToPresenter(foods:[Yemekler])
    func showError(error:Error)
}

protocol PresenterToViewHomeProtocol {
    func sendDataToView(foods:[Yemekler])
    func showError(error:Error)
}


// Router Protocol
protocol PresenterToRouterHomeProtocol {
    static func createModule(ref:HomeViewController)
}
