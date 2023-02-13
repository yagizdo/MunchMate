//
//  AuthService.swift
//  FoodDeliveryApp
//
//  Created by Yılmaz Yağız Dokumacı on 8.02.2023.
//

import Foundation
import Firebase
import UIKit

class AuthService : IAuthService {
    
    // Auth Object
    let auth:Auth
    
    // Current User
    var currentUser: User? {
        get {
            return getCurrentUser()
        }
    }
    
    // State change handler
    let stateChangeHandler:AuthStateDidChangeListenerHandle
    
    
    init() {
        auth = Auth.auth()
        stateChangeHandler = auth.addStateDidChangeListener({
            auth,user in
            
        })
    }
    
    func changeDefaultView() {
        let board = UIStoryboard(name: "Main", bundle: nil)
        let home = board.instantiateViewController(withIdentifier: "homeView") as! HomeViewController
        UIApplication.shared.keyWindow?.rootViewController = home
    }
    
    
    func getCurrentUser() -> User? {
        if let currUser = auth.currentUser {
            return currUser
        }
        return nil
    }
    
    
    func register(userEmail: String, userPassword: String, userName: String, onSuccess: @escaping (Bool) -> Void, onFailure: @escaping (Error) -> Void) {
        auth.createUser(withEmail: userEmail, password: userPassword) {
            authResult, error in
            if error != nil {
                
                onFailure(error!)
                print(error?.localizedDescription as Any)
            } else {
                self.setUserName(userName: userName) {
                    error in
                    onFailure(error)
                }
                onSuccess(true)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.changeDefaultView()
                 }
                
                print("Login successful ")
            }
        }
    }
    
    
    
    
    
    
    func setUserName(userName:String,onFailure: @escaping (Error) -> Void) {
        let changeRequest = currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = userName
        changeRequest?.commitChanges() {
          error in
            if error != nil {
                onFailure(error!)
            } else {
                print("Name changed succesfuly")
            }
        }
    }
    
    func dispose() {
        auth.removeStateDidChangeListener(stateChangeHandler)
    }
    
    func logout() {
        do {
            try auth.signOut()
            dispose()
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
