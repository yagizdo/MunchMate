//
//  RegisterViewController.swift
//  FoodDeliveryApp
//
//  Created by Yılmaz Yağız Dokumacı on 8.02.2023.
//

import UIKit

class RegisterViewController: UIViewController {
    
    // Profile Image List
    var profileImages = [UIImage(named: "maleProfile"),UIImage(named: "femaleProfile"),UIImage(named: "maleProfile2"),UIImage(named: "femaleProfile2")]
    
    // Selected Profile Image Index
    var selectedProfileIndex = 0
    
    // Profile image view
    @IBOutlet weak var profileImageView: UIImageView!

    // Image Buttons
    private let leftArrowButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 0
        button.tintColor = UIColor(named: "activeOrangeColor") ?? UIColor.black
        
        let image = UIImage(systemName: "arrow.left",withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .medium))
        button.setImage(image, for: .normal)
        return button
    }()
    
    private let rightArrowButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 0
        button.tintColor = UIColor(named: "activeOrangeColor") ?? UIColor.black
        let image = UIImage(systemName: "arrow.right",withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .medium))
        button.setImage(image, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Profile Image View
        profileImageView.image = profileImages[selectedProfileIndex]
        // Left Button
        view.addSubview(leftArrowButton)
        leftArrowButton.addTarget(self, action: #selector(buttonLeftArrowClick), for: .touchUpInside)
        
        // Right Button
        view.addSubview(rightArrowButton)
        rightArrowButton.addTarget(self, action: #selector(buttonRightArrowClick), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        leftArrowButton.frame = CGRect(x: 20, y: 180, width: 60, height: 60)
        rightArrowButton.frame = CGRect(x: 340, y: 180, width: 60, height: 60)
    }
    
    // Left button click method
    @objc private func buttonRightArrowClick() {
       changeProfileImage(isIncrease: true)
    }
    
    
    // Right button click method
    @objc private func buttonLeftArrowClick() {
        changeProfileImage(isIncrease: false)
    }
    
    
    func changeProfileImage(isIncrease:Bool) {
        if isIncrease {
            if selectedProfileIndex < profileImages.count - 1 {
                selectedProfileIndex += 1
                profileImageView.image = profileImages[selectedProfileIndex]
            }
        } else {
            if selectedProfileIndex > 0 {
                selectedProfileIndex -= 1
                profileImageView.image = profileImages[selectedProfileIndex]
            }
        }
    }
}
