//
//  AlertManager.swift
//  FoodDeliveryApp
//
//  Created by Yılmaz Yağız Dokumacı on 13.02.2023.
//

import UIKit

class AlertManager {
    private static func showBasicAlert(vc : UIViewController, title:String, message:String?) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel)
            alert.addAction(dismissAction)
            vc.present(alert, animated: true)
        }
    }
}


// MARK: - Validation Alerts
extension AlertManager {
    public static func showInvalidEmailAlert(vc: UIViewController) {
        self.showBasicAlert(vc: vc, title: "Invalid Email", message: "Please write a valid Email")
    }
}
