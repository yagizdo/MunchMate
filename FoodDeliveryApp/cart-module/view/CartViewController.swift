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
        
        let section = 0
        cartFoodsTableView.reloadSections([section], with: .automatic)
    }
    
    func calculateTotalPrice() {
        totalPrice =  0
        for food in cartFoods {
            totalPrice += (Int(food.yemek_fiyat!)! * Int(food.yemek_siparis_adet!)!)
        }
        totalCartPriceLabel.text = "\(totalPrice) ₺"
        checkoutCartTotalPriceLabel.text = "\(totalPrice) ₺"
    }
}

extension CartViewController : PresenterToViewCartProtocol {
    func sendDataToView(cartFoods: [SepetYemekler]) {
        UIView.animate(withDuration: 0.5) {
            self.cartFoods = cartFoods
            self.tabBarItem.badgeValue = "\(cartFoods.count)"
            self.calculateTotalPrice()
            let section = 0
            self.cartFoodsTableView.reloadSections([section], with: .automatic)
            self.view.layoutIfNeeded()
        }
  
    }
    
    func sendDataToView(isSuccess: Bool) {
        AlertManager.showSuccessSnackBar(vc: self, message: "Successful")
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
        cell.foodAmountLabel.text = "\(cartFood.yemek_siparis_adet!) pieces"
        // Get food image
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(cartFood.yemek_resim_adi!)") {
            DispatchQueue.main.async {
                cell.foodImageView.kf.setImage(with: url)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            let cartFood = self.cartFoods[indexPath.row]
            DispatchQueue.main.async {
                if let userEmail = AuthService.shared.currentUser?.email {
                    self.cartPresenterDelegate?.removeFoodFromCart(food_id: Int(cartFood.sepet_yemek_id!)! , userMail: userEmail )
                }
            }
            completion(true)
        }
            
        // Silme düğmesinin arka plan rengini ayarla
        deleteAction.backgroundColor = UIColor.red
            
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = true // Kaydırma işlemi tamamlandığında, eylemi otomatik olarak gerçekleştir
            
        return configuration
    }
    
}
