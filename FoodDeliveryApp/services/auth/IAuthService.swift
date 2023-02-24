//
//  IAuthService.swift
//  FoodDeliveryApp
//
//  Created by Yılmaz Yağız Dokumacı on 8.02.2023.
//

import Foundation
import Firebase

protocol IAuthService {
    func register(userEmail:String,userPassword:String,userName:String,onSuccess: @escaping (Bool) -> Void,onFailure: @escaping (Error) -> Void)
    func login(userEmail:String,userPassword:String,onSuccess: @escaping (Bool) -> Void,onFailure: @escaping (Error) -> Void)
    func getCurrentUser()->User?
    func dispose()
    func logout(onSuccess: @escaping (Bool) -> Void,onFailure: @escaping (Error) -> Void)
}
