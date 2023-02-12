//
//  RegisterProtocols.swift
//  FoodDeliveryApp
//
//  Created by Yılmaz Yağız Dokumacı on 8.02.2023.
//

import Foundation

protocol ViewToPresenterRegisterProtocol {
    
    var interactor:PresenterToInteractorRegisterProtocol? {get set}
    
    
    func register(userEmail:String,userPassword:String,userName:String)
    
}

protocol PresenterToInteractorRegisterProtocol {
    func register(userEmail:String,userPassword:String,userName:String)
}


// Router Protocol
protocol PresenterToRouterRegisterProtocol {
    static func createModule(ref:RegisterViewController)
}
