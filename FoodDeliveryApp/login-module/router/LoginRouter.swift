//
//  LoginRouter.swift
//  FoodDeliveryApp
//
//  Created by Yılmaz Yağız Dokumacı on 11.02.2023.
//

import Foundation

class LoginRouter : PresenterToRouterLoginProtocol {
    static func createModule(ref: LoginViewController) {

        let presenter = LoginPresenter()
        
        // View
        ref.loginPresenterDelegate = presenter
        
        // Presenter
        ref.loginPresenterDelegate?.view = ref
        ref.loginPresenterDelegate?.interactor = LoginInteractor()
        
        // Interactor
        ref.loginPresenterDelegate?.interactor?.presenter = presenter
    }
}
