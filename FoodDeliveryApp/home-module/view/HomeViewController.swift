//
//  HomeViewController.swift
//  FoodDeliveryApp
//
//  Created by Yılmaz Yağız Dokumacı on 12.02.2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /// Hide Navigation Controller
        self.navigationController?.isNavigationBarHidden = true
        // disable pop gesture
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }

    @IBAction func logoutTestButton(_ sender: Any) {
        AuthService.shared.logout()
    }
}
