//
//  LoginViewController.swift
//  FoodDeliveryApp
//
//  Created by Yılmaz Yağız Dokumacı on 11.02.2023.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set Textfields Left padding
        setTextfieldsLeftPadding(textfield: emailTF)
        setTextfieldsLeftPadding(textfield: passwordTF)
    }
    
    func setTextfieldsLeftPadding(textfield:UITextField) {
        textfield.setLeftPadding(10)
    }
    
    @IBAction func buttonLoginOnClick(_ sender: Any) {
    }
    
}
