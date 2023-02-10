//
//  WelcomeViewController.swift
//  FoodDeliveryApp
//
//  Created by Yılmaz Yağız Dokumacı on 10.02.2023.
//

import UIKit

class WelcomeViewController: UIViewController {

    
    @IBOutlet weak var welcomeImageView: UIImageView!
    
    @IBOutlet weak var googleLogoImageView: UIImageView!
    
    @IBOutlet weak var appleLogoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add google logo to image view
        googleLogoImageView.image = UIImage(named: "googleLogo")
    }
    
    @IBAction func buttonSignInWithGoogle(_ sender: Any) {
        print("test ayol")
    }
    
    @IBAction func buttonSignInWithApple(_ sender: Any) {
        print("yan gele")
    }
    
}
