//
//  AuthService.swift
//  FoodDeliveryApp
//
//  Created by Yılmaz Yağız Dokumacı on 8.02.2023.
//

import Foundation
import Firebase

class AuthService : IAuthService {
    
    // Auth Object
    let auth:Auth
    
    // State change handler
    let stateChangeHandler:AuthStateDidChangeListenerHandle
    
    
    init() {
        auth = Auth.auth()
        stateChangeHandler = auth.addStateDidChangeListener({
            auth,user in
            
        })
    }
    
    
    func getCurrentUser() -> User? {
        if let currUser = auth.currentUser {
            return currUser
        }
        return nil
    }
    
    func register(userEmail: String, userPassword: String) {
        auth.createUser(withEmail: userEmail, password: userPassword) {
            authResult, error in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                print("Login successful ")
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
