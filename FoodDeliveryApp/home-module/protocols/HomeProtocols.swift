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
    func getFoodsByCategory(categoryName:String)
}

protocol PresenterToInteractorHomeProtocol {
    var homePresenter : InteractorToPresenterHomeProtocol? {get set}
    
    func getAllFoods()
    func getFoodsByCategory(categoryName:String)
}

protocol InteractorToPresenterHomeProtocol {
    func sendDataToPresenter(foods:[Yemekler])
    func showError(error:Error)
}

protocol PresenterToViewHomeProtocol {
    func sendDataToView(foods:[Yemekler])
    func showError(error:Error)
}

// Food Detail Protocol for segue
protocol FoodsViewtoFoodDetailProtocol {
    func goFoodDetail()
}


// Router Protocol
protocol PresenterToRouterHomeProtocol {
    static func createModule(ref:HomeViewController)
}
