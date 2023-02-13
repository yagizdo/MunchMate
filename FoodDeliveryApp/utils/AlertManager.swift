//
//  AlertManager.swift
//  FoodDeliveryApp
//
//  Created by Yılmaz Yağız Dokumacı on 13.02.2023.
//

import UIKit

class AlertManager {
    
   static func showBasicAlert(vc : UIViewController, title:String, message:String?) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel)
            alert.addAction(dismissAction)
            vc.present(alert, animated: true)
        }
    }
    
    
    static func showSuccessSnackBar(vc : UIViewController, message:String) {
        SuccessSnackBar.make(in: vc.view, message: message, duration: .lengthShort).show()
    }
    
    static func showAuthErrorSnackBar(vc : UIViewController, message:String) {
        AuthErrorSnackbar.make(in: vc.view, message: message, duration: .lengthShort).show()
    }
}


