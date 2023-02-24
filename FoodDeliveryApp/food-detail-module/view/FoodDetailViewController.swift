//
//  FoodDetailViewController.swift
//  FoodDeliveryApp
//
//  Created by Yılmaz Yağız Dokumacı on 21.02.2023.
//

import UIKit
import DSFStepperView

class FoodDetailViewController: UIViewController {
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var favButton: UIButton!
    
    @IBOutlet weak var detailBackgroundView: UIView!
    
    @IBOutlet weak var foodImage: UIImageView!
    
    @IBOutlet weak var foodStepperView: DSFStepperView!
    
    @IBOutlet weak var foodTitleLabel: UILabel!
    
    @IBOutlet weak var foodPriceLabel: UILabel!
    
    @IBOutlet weak var foodStarLabel: UILabel!
    
    @IBOutlet weak var foodDescriptionLabel: UILabel!
    
    @IBOutlet weak var foodImageLoadingIndicator: UIActivityIndicatorView!
    
    var incomingFood : Yemekler?
    
    var foodAmountValue = 0
    
    var foodDetailPresenterDelegate : ViewToPresenterFoodDetailProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
                // Add custom swipe gesture recognizer
                let swipeBackGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeBack(_:)))
                swipeBackGesture.direction = .right
                self.view.addGestureRecognizer(swipeBackGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavController()
            
        backButton.layer.cornerRadius = backButton.frame.width / 2
        backButton.layer.masksToBounds = true
        
        // Fav Button
        favButton.layer.cornerRadius = favButton.frame.width / 2
        favButton.layer.masksToBounds = true
        
        // Background View
        detailBackgroundView.clipsToBounds = true
        detailBackgroundView.layer.cornerRadius = 50
        detailBackgroundView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        // We turn the Food Image into a circle.
        foodImage.layer.borderWidth = 5
        foodImage.layer.masksToBounds = false
        foodImage.layer.borderColor = UIColor.white.cgColor
        foodImage.layer.cornerRadius = foodImage.frame.height/2
        foodImage.clipsToBounds = true
        
        foodDescriptionLabel.spacing = 6
        
        // Stepper
        foodStepperView.delegate = self
        foodStepperView.initialValue = CGFloat(foodAmountValue)
        
        // Set food
        if let food = incomingFood {
            self.foodTitleLabel.text = food.yemek_adi!
            self.foodPriceLabel.text = ("\(food.yemek_fiyat!) ₺")
            foodImage.isHidden = true
            foodImageLoadingIndicator.hidesWhenStopped = true
            foodImageLoadingIndicator.startAnimating()
            // Get food image
            if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(food.yemek_resim_adi!)") {
                DispatchQueue.main.async {
                    self.foodImage.kf.setImage(with: url)
                }
                foodImageLoadingIndicator.stopAnimating()
                foodImage.isHidden = false
            }
        }
        
        // Create a module
        FoodDetailRouter.createModule(ref: self)
    }
    
    @IBAction func addToCartButtonOnClick(_ sender: Any) {
        if let userEmail = AuthService.shared.currentUser?.email {
            if let food = incomingFood {
                foodDetailPresenterDelegate?.addFoodToCart(userMail: userEmail, food: food, piece: foodAmountValue)
            }
        }
            // Set carts badge
            if let userEmail = AuthService.shared.currentUser?.email {
                NetworkService.shared.calculateCartItemsBadge(userMail: userEmail, vc: self)
            }
        
    }
    
    @objc func swipeBack(_ gesture: UISwipeGestureRecognizer) {
          self.navigationController?.popViewController(animated: true)
      }
    
    @IBAction func backButtonOnclick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func favButtonOnclick(_ sender: Any) {
    }
    
    private func setupNavController() {
        // Hide Navigation Bar without losing slide-back ability
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

// Stepper Extension
extension FoodDetailViewController : DSFStepperViewDelegateProtocol {
    func stepperView(_ view: DSFStepperView, didChangeValueTo value: NSNumber?) {
        foodAmountValue = Int(truncating: value ?? 0)
    }
}

// Get add food response
extension FoodDetailViewController : PresenterToViewFoodDetailProtocol {
    func sendDataToView(isSuccess: Bool) {
        if isSuccess {
            AlertManager.showSuccessSnackBar(vc: self, message: "\(foodAmountValue) pieces of \(incomingFood?.yemek_adi ?? "No data") added to the cart")
        } else {
            AlertManager.showErrorSnackBar(vc: self, message: "The value you want to add must be greater than 0.")
        }
    }
    
    func showError(error: Error) {
        AlertManager.showErrorSnackBar(vc: self, message: "Something went wrong!")
    }
}
extension FoodDetailViewController : UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

// Custom label. Text starting on top
class TopAlignedLabel: UILabel {
  override func drawText(in rect: CGRect) {
    let textRect = super.textRect(forBounds: bounds, limitedToNumberOfLines: numberOfLines)
    super.drawText(in: textRect)
  }
}
