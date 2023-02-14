//
//  AuthExceptionsHandler.swift
//  FoodDeliveryApp
//
//  Created by Yılmaz Yağız Dokumacı on 14.02.2023.
//

import Foundation
import Firebase

// MARK: Firebase Auth Error Message Generate
extension AuthErrorCode {
    var generateErrorMessage: String {
        switch self.code {
        case .invalidEmail:
            return "Please enter a valid email"
        case .invalidPhoneNumber:
            return "Your phone number is invalid."
        case .invalidVerificationCode:
            return "The code you entered is incorrect."
        case .weakPassword:
            return "Your password is too weak"
        case .wrongPassword:
            return "Email address or password is incorrect."
        case .userNotFound:
            return "Email address or password is incorrect."
        case .userDisabled:
            return "User account is not active."
        case .tooManyRequests:
            return "Too many requests sent. Please try again later."
        case .operationNotAllowed:
            return "Login with e-mail address is not allowed."
        case .emailAlreadyInUse:
            return "An account has already been created with this E-mail address. Please use another email address."
        case .invalidCredential:
            return "Invalid credentials. Please try again."
        case .credentialAlreadyInUse:
            return "An account has already been created with this E-mail address. Please use another email address."
        case .accountExistsWithDifferentCredential:
            return "An account has already been created with this E-mail address. Please use another email address."
        case .expiredActionCode:
            return "Your password reset code has expired."
        case .invalidVerificationID:
            return "ID is not valid."
        case .networkError:
            return "Network error. Please try again."
        default:
            return "Something went wrong!"
        }
    }
}
