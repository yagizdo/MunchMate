//
//  RegisterInteractor.swift
//  FoodDeliveryApp
//
//  Created by Yılmaz Yağız Dokumacı on 8.02.2023.
//

import Foundation


class RegisterInteractor : PresenterToInteractorRegisterProtocol {
    
    var authService:AuthService?

    var presenter: InteractorToPresenterRegisterProtocol?
    
    init() {
        authService = AuthService()
        
    }
    func register(userEmail: String, userPassword: String, userName: String) {
        authService?.register(userEmail: userEmail, userPassword: userPassword,userName:userName) {
            error in
            self.presenter?.showError(error: error)
            print("Interactor error : \(error.localizedDescription)")
        }
    }
}
