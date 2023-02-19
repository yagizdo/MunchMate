//
//  HomeInteractor.swift
//  FoodDeliveryApp
//
//  Created by Yılmaz Yağız Dokumacı on 12.02.2023.
//

import Foundation

class HomeInteractor : PresenterToInteractorHomeProtocol {
    var homePresenter: InteractorToPresenterHomeProtocol?
    
    var networkService:NetworkService?
    
    init() {
        networkService = NetworkService.shared
    }
    
    func getAllFoods() {
        networkService?.getAllFoods(onSuccess: { foods in
            self.homePresenter?.sendDataToPresenter(foods: foods)
        }, onFailure: { error in
            self.homePresenter?.showError(error: error)
        })
    }
    
    func getFoodsByCategory(categoryName: String) {
        networkService?.getFoodsByCategory(categoryName: categoryName, onSuccess: { foods in
            self.homePresenter?.sendDataToPresenter(foods: foods)
        })
    }
}
