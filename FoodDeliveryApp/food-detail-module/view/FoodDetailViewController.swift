//
//  FoodDetailViewController.swift
//  FoodDeliveryApp
//
//  Created by Yılmaz Yağız Dokumacı on 21.02.2023.
//

import UIKit

class FoodDetailViewController: UIViewController {
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Add custom swipe gesture recognizer
                let swipeBackGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeBack(_:)))
                swipeBackGesture.direction = .right
                self.view.addGestureRecognizer(swipeBackGesture)
    }
    
    @objc func swipeBack(_ gesture: UISwipeGestureRecognizer) {
          self.navigationController?.popViewController(animated: true)
      }
    
    @IBAction func backButtonOnclick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            setupNavController()
            backButton.layer.cornerRadius = backButton.frame.width / 2
            backButton.layer.masksToBounds = true
    }
    
    private func setupNavController() {
        // Hide Navigation Bar without losing slide-back ability
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

extension FoodDetailViewController : UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
