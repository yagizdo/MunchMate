//
//  LoginProtocols.swift
//  FoodDeliveryApp
//
//  Created by Yılmaz Yağız Dokumacı on 11.02.2023.
//

import Foundation

protocol ViewToPresenterLoginProtocol {
    var interactor : PresenterToInteractorLoginProtocol? {get set}
    var view : PresenterToViewLoginProtocol? {get set}
    
    func loginWithEmailAndPassword(userEmail:String,userPassword:String)
}

protocol PresenterToInteractorLoginProtocol {
    
    var presenter : InteractorToPresenterLoginProtocol? {get set}
    
    func loginWithEmailAndPassword(userEmail:String,userPassword:String)
}


protocol InteractorToPresenterLoginProtocol {
    func showError(error:Error)
    func showSuccess()
}

protocol PresenterToViewLoginProtocol {
    func showError(error:Error)
    func showSuccess()
}


// Router Protocol

protocol PresenterToRouterLoginProtocol {
    static func createModule(ref:LoginViewController)
}
