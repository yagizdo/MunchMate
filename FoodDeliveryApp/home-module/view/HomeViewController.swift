//
//  HomeViewController.swift
//  FoodDeliveryApp
//
//  Created by Yılmaz Yağız Dokumacı on 12.02.2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var navbarProfileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /// Hide Navigation Controller
        self.navigationController?.isNavigationBarHidden = true
        // disable pop gesture
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        // We turn the profile picture into a circle.
        navbarProfileImage.layer.borderWidth = 1
        navbarProfileImage.layer.masksToBounds = false
        navbarProfileImage.layer.borderColor = UIColor.black.cgColor
        navbarProfileImage.layer.cornerRadius = navbarProfileImage.frame.height/2
        navbarProfileImage.clipsToBounds = true
    }
}
