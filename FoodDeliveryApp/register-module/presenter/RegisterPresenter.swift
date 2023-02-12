//
//  RegisterPresenter.swift
//  FoodDeliveryApp
//
//  Created by Yılmaz Yağız Dokumacı on 8.02.2023.
//

import Foundation

class RegisterPresenter : ViewToPresenterRegisterProtocol {
    var interactor: PresenterToInteractorRegisterProtocol?
    
    func register(userEmail: String, userPassword: String,userName:String) {
        interactor?.register(userEmail: userEmail, userPassword: userPassword,userName: userName)
    }
}
