//
//  WelcomeProtocols.swift
//  FoodDeliveryApp
//
//  Created by Yılmaz Yağız Dokumacı on 10.02.2023.
//

import Foundation

protocol ViewToPresenterWelcomeProtocol {
    
    var interactor:PresenterToInteractorWelcomeProtocol? {get set}
    
    func signInWithGoogle()
}

protocol PresenterToInteractorWelcomeProtocol {
    func signInWithGoogle()
}



// Router Protocol
protocol PresenterToRouterWelcomeProtocol {
    static func createModule(ref:WelcomeViewController)
}
