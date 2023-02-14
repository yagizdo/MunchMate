//
//  LoginPresenter.swift
//  FoodDeliveryApp
//
//  Created by Yılmaz Yağız Dokumacı on 11.02.2023.
//

import Foundation

class LoginPresenter : ViewToPresenterLoginProtocol {
    var interactor: PresenterToInteractorLoginProtocol?
    var view: PresenterToViewLoginProtocol?
    
    func loginWithEmailAndPassword(userEmail: String, userPassword: String) {
        interactor?.loginWithEmailAndPassword(userEmail: userEmail, userPassword: userPassword)
    }
}

extension LoginPresenter : InteractorToPresenterLoginProtocol {
    func showError(error: Error) {
        view?.showError(error: error)
    }
    
    func showSuccess() {
        view?.showSuccess()
    }
}
