//
//  RegisterProtocols.swift
//  FoodDeliveryApp
//
//  Created by Yılmaz Yağız Dokumacı on 8.02.2023.
//

import Foundation

protocol ViewToPresenterRegisterProtocol {
    var view: PresenterToViewRegisterProtocol? {get set}
    var interactor:PresenterToInteractorRegisterProtocol? {get set}
    
    
    func register(userEmail:String,userPassword:String,userName:String)
    
}

protocol PresenterToInteractorRegisterProtocol {
    var presenter : InteractorToPresenterRegisterProtocol? {get set}
    
    func register(userEmail:String,userPassword:String,userName:String)
}

protocol InteractorToPresenterRegisterProtocol {
    func showError(error:Error)
    func showSuccess()
}

protocol PresenterToViewRegisterProtocol {
    func showError(error:Error)
    func showSuccess()
}

// Router Protocol
protocol PresenterToRouterRegisterProtocol {
    static func createModule(ref:RegisterViewController)
}
