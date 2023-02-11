//
//  LoginProtocols.swift
//  FoodDeliveryApp
//
//  Created by Yılmaz Yağız Dokumacı on 11.02.2023.
//

import Foundation

protocol ViewToPresenterLoginProtocol {
    var interactor : PresenterToInteractorLoginProtocol? {get set}
    
    func loginWithEmailAndPassword(userEmail:String,userPassword:String)
}

protocol PresenterToInteractorLoginProtocol {
    func loginWithEmailAndPassword(userEmail:String,userPassword:String)
}



// Router Protocol

protocol PresenterToRouterLoginProtocol {
    static func createModule(ref:LoginViewController)
}
