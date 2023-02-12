//
//  RegisterInteractor.swift
//  FoodDeliveryApp
//
//  Created by Yılmaz Yağız Dokumacı on 8.02.2023.
//

import Foundation


class RegisterInteractor : PresenterToInteractorRegisterProtocol {
    
    var authService:AuthService?
 
    
    init() {
        authService = AuthService()
        
    }
    func register(userEmail: String, userPassword: String, userName: String) {
        authService?.register(userEmail: userEmail, userPassword: userPassword,userName:userName)
    }
}
