//
//  CartViewController.swift
//  FoodDeliveryApp
//
//  Created by Yılmaz Yağız Dokumacı on 22.02.2023.
//

import UIKit

class CartViewController: UIViewController {

    
    @IBOutlet weak var checkoutDividerView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set checkout divider alpha
        checkoutDividerView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
    }
}
