//
//  CartViewController.swift
//  FoodDeliveryApp
//
//  Created by Yılmaz Yağız Dokumacı on 22.02.2023.
//

import UIKit

class CartViewController: UIViewController {

    
    @IBOutlet weak var checkoutDividerView: UIView!
    
    @IBOutlet weak var cartFoodsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set checkout divider alpha
        checkoutDividerView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        
        // Table View
        cartFoodsTableView.delegate = self
        cartFoodsTableView.dataSource = self
        cartFoodsTableView.separatorStyle = .none
    }
}

extension CartViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cartFoodsTableView.dequeueReusableCell(withIdentifier: "cartFoodCell", for: indexPath) as! CartFoodTableViewCell
        
        cell.background.cornerRadius = 10
        cell.backgroundColor = UIColor(named: "backgroundColor")!
        cell.background.backgroundColor = UIColor.white
        
        cell.selectionStyle = .none
        
        cell.foodTitleLabel.text = "Ayran"
        cell.foodImageView.image = UIImage(named: "ayran")
        
        return cell
    }
    
    
}
