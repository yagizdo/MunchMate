//
//  RegisterRouter.swift
//  FoodDeliveryApp
//
//  Created by Yılmaz Yağız Dokumacı on 8.02.2023.
//

import Foundation

class RegisterRouter : PresenterToRouterRegisterProtocol {
    static func createModule(ref: RegisterViewController) {
        
        let presenter = RegisterPresenter()
        
        // View
        ref.registerPresenterDelegate = presenter
        
        // Presenter
        ref.registerPresenterDelegate?.view = ref
        ref.registerPresenterDelegate?.interactor = RegisterInteractor()
        
        // Interactor
        ref.registerPresenterDelegate?.interactor?.presenter = presenter
    }
}
