//
//  LoginPresenter.swift
//  FoodDeliveryApp
//
//  Created by Yılmaz Yağız Dokumacı on 11.02.2023.
//

import Foundation

class LoginPresenter : ViewToPresenterLoginProtocol {
    var interactor: PresenterToInteractorLoginProtocol?
    
    func loginWithEmailAndPassword(userEmail: String, userPassword: String) {
        interactor?.loginWithEmailAndPassword(userEmail: userEmail, userPassword: userPassword)
    }
}
