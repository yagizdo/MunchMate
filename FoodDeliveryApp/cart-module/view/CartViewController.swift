//
//  CartViewController.swift
//  FoodDeliveryApp
//
//  Created by Yılmaz Yağız Dokumacı on 22.02.2023.
//

import UIKit
import Kingfisher

class CartViewController: UIViewController {

    
    @IBOutlet weak var checkoutDividerView: UIView!
    
    @IBOutlet weak var cartFoodsTableView: UITableView!
    
    @IBOutlet weak var cartItemsCountLabel: UILabel!
    
    @IBOutlet weak var totalCartPriceLabel: UILabel!
    
    @IBOutlet weak var checkoutCartTotalPriceLabel: UILabel!

    var cartFoods = [SepetYemekler]()

    var totalPrice = 0
    
    // Cart presenter delegate
    var cartPresenterDelegate : ViewToPresenterCartProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set checkout divider alpha
        checkoutDividerView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        
        // Table View
        cartFoodsTableView.delegate = self
        cartFoodsTableView.dataSource = self
        cartFoodsTableView.separatorStyle = .none
        
        // Create Module
        CartRouter.createModule(ref: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Get all cart items
        cartPresenterDelegate?.getAllCartItems()
    }
    
    func calculateTotalPrice() {
        totalPrice =  0
        for food in cartFoods {
            totalPrice += Int(food.yemek_fiyat!)!
        }
        totalCartPriceLabel.text = "\(totalPrice) ₺"
        checkoutCartTotalPriceLabel.text = "\(totalPrice) ₺"
    }
}

extension CartViewController : PresenterToViewCartProtocol {
    func sendDataToView(cartFoods: [SepetYemekler]) {
        self.cartFoods = cartFoods
        self.tabBarItem.badgeValue = "\(cartFoods.count)"
        calculateTotalPrice()
        cartFoodsTableView.reloadData()
    }
    
    func showError(error: Error) {
        AlertManager.showErrorSnackBar(vc: self, message: "Something went wrong!")
    }
}

extension CartViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cartItemsCountLabel.text = "\(cartFoods.count) Items"
        return cartFoods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cartFoodsTableView.dequeueReusableCell(withIdentifier: "cartFoodCell", for: indexPath) as! CartFoodTableViewCell
        let cartFood = cartFoods[indexPath.row]
        
        cell.background.cornerRadius = 10
        cell.backgroundColor = UIColor(named: "backgroundColor")!
        cell.background.backgroundColor = UIColor.white
        
        cell.selectionStyle = .none
        
        cell.foodTitleLabel.text = cartFood.yemek_adi
        cell.foodPriceLabel.text = "\(cartFood.yemek_fiyat!) ₺"
        // Get food image
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(cartFood.yemek_resim_adi!)") {
            DispatchQueue.main.async {
                cell.foodImageView.kf.setImage(with: url)
            }
        }
        
        return cell
    }
}
