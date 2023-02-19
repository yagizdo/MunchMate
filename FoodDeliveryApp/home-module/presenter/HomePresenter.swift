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
}

extension HomePresenter : InteractorToPresenterHomeProtocol {
    func sendDataToPresenter(foods: [Yemekler]) {
        homeView?.sendDataToView(foods: foods)
    }
    
    func showError(error: Error) {
        homeView?.showError(error: error)
    }
}
