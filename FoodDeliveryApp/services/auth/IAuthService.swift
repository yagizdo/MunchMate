//
//  IAuthService.swift
//  FoodDeliveryApp
//
//  Created by Yılmaz Yağız Dokumacı on 8.02.2023.
//

import Foundation
import Firebase

protocol IAuthService {
    func register(userEmail:String,userPassword:String)
    func getCurrentUser()->User?
    func dispose()
    func logout()
}
