//
//  HomePresenter.swift
//  FoodDeliveryApp
//
//  Created by Yılmaz Yağız Dokumacı on 12.02.2023.
//

import Foundation

class HomePresenter : ViewToPresenterHomeProtocol {
    var homeView: PresenterToViewHomeProtocol?
    var homeInteractor: PresenterToInteractorHomeProtocol?
    
    func getAllFoods() {
        homeInteractor?.getAllFoods()
    }
    
    func getFoodsByCategory(categoryName: String) {
        homeInteractor?.getFoodsByCategory(categoryName: categoryName)
    }
    
    func search(searchText: String) {
        homeInteractor?.search(searchText: searchText)
    }
}

extension HomePresenter : InteractorToPresenterHomeProtocol {
    func sendDataToPresenter(foods: [Yemekler]) {
        homeView?.sendDataToView(foods: foods)
    }
    
    func showError(error: Error) {
        homeView?.showError(error: error)
    }
}
