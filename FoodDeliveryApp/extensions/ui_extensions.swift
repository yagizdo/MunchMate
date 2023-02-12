//
//  ui_extensions.swift
//  FoodDeliveryApp
//
//  Created by Yılmaz Yağız Dokumacı on 11.02.2023.
//

import Foundation
import UIKit

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}
    

extension UITextField {

    func setLeftPadding(_ amount: CGFloat = 10) {

        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.bounds.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }

    func setRightPadding(_ amount: CGFloat = 10) {

        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.bounds.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

extension UIApplication {
    
    var keyWindow: UIWindow? {
        // Get connected scenes
        return UIApplication.shared.connectedScenes
            // Keep only active scenes, onscreen and visible to the user
            .filter { $0.activationState == .foregroundActive }
            // Keep only the first `UIWindowScene`
            .first(where: { $0 is UIWindowScene })
            // Get its associated windows
            .flatMap({ $0 as? UIWindowScene })?.windows
            // Finally, keep only the key window
            .first(where: \.isKeyWindow)
    }
    
}
