//
//  RegisterRouter.swift
//  FoodDeliveryApp
//
//  Created by Yılmaz Yağız Dokumacı on 8.02.2023.
//

import Foundation

class RegisterRouter : PresenterToRouterRegisterProtocol {
    static func createModule(ref: RegisterViewController) {
        
        // View
        ref.registerPresenterDelegate = RegisterPresenter()
        
        // Presenter
        ref.registerPresenterDelegate?.interactor = RegisterInteractor()
    }
}
