//
//  WelcomeViewController.swift
//  FoodDeliveryApp
//
//  Created by Yılmaz Yağız Dokumacı on 10.02.2023.
//

import UIKit

class WelcomeViewController: UIViewController {

    
    @IBOutlet weak var welcomeImageView: UIImageView!
    
    @IBOutlet weak var btnSignWithEmail: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func buttonSignInWithEmail(_ sender: Any) {
        performSegue(withIdentifier: "toLogin", sender: nil)
    }
    
    @IBAction func buttonSignUp(_ sender: Any) {
        performSegue(withIdentifier: "toRegister", sender: nil)
    }
    
}
