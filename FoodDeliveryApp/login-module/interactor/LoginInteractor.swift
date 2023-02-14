//
//  LoginInteractor.swift
//  FoodDeliveryApp
//
//  Created by Yılmaz Yağız Dokumacı on 11.02.2023.
//

import Foundation

class LoginInteractor : PresenterToInteractorLoginProtocol {
    
    var authService:AuthService?

    var presenter: InteractorToPresenterLoginProtocol?
    
    init() {
        authService = AuthService.shared
    }
    
    func loginWithEmailAndPassword(userEmail: String, userPassword: String) {
        authService?.login(userEmail: userEmail, userPassword: userPassword, onSuccess: { isSuccess in
            if isSuccess {
                self.presenter?.showSuccess()
            }
        }, onFailure: { error in
            self.presenter?.showError(error: error)
        })
    }
}
