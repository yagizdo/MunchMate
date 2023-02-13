//
//  RegisterViewController.swift
//  FoodDeliveryApp
//
//  Created by Yılmaz Yağız Dokumacı on 8.02.2023.
//

import UIKit

class RegisterViewController: UIViewController {
    // Profile image view
    @IBOutlet weak var profileImageView: UIImageView!

    @IBOutlet weak var userNameTF: UITextField!
    
    @IBOutlet weak var userEmailTF: UITextField!
    
    @IBOutlet weak var userPasswordTF: UITextField!
    
    @IBOutlet weak var userPasswordConfirmTF: UITextField!
    
    @IBOutlet weak var passwordConfirmBottomConstraint: NSLayoutConstraint!
    
    var registerPresenterDelegate:ViewToPresenterRegisterProtocol?
    
    // Profile Image List
    var profileImages = [UIImage(named: "maleProfile"),UIImage(named: "femaleProfile"),UIImage(named: "maleProfile2"),UIImage(named: "femaleProfile2")]
    
    // Selected Profile Image Index
    var selectedProfileIndex = 0
    
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
    
    func setTextfieldsLeftPadding(textfield:UITextField) {
        textfield.setLeftPadding(10)
    }
    
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
        
        // Set Textfields Left padding
        setTextfieldsLeftPadding(textfield: userNameTF)
        setTextfieldsLeftPadding(textfield: userEmailTF)
        setTextfieldsLeftPadding(textfield: userPasswordTF)
        setTextfieldsLeftPadding(textfield: userPasswordConfirmTF)
        
        initializeHideKeyboard()
        // Notifications for when the keyboard opens/closes
              NotificationCenter.default.addObserver(
                  self,
                  selector: #selector(self.keyboardWillShow),
                  name: UIResponder.keyboardWillShowNotification,
                  object: nil)

              NotificationCenter.default.addObserver(
                  self,
                  selector: #selector(self.keyboardWillHide),
                  name: UIResponder.keyboardWillHideNotification,
                  object: nil)
        
        RegisterRouter.createModule(ref: self)
    }
    
    override func viewDidLayoutSubviews() {
        leftArrowButton.frame = CGRect(x: 20, y: 205, width: 60, height: 60)
        rightArrowButton.frame = CGRect(x: 340, y: 205, width: 60, height: 60)
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
            } else {
                selectedProfileIndex = 0
                profileImageView.image = profileImages[selectedProfileIndex]
            }
        } else {
            if selectedProfileIndex > 0 {
                selectedProfileIndex -= 1
                profileImageView.image = profileImages[selectedProfileIndex]
            } else {
                selectedProfileIndex = profileImages.count - 1
                profileImageView.image = profileImages[selectedProfileIndex]
            }
        }
    }
    
    
    @IBAction func buttonCreateAccountOnClick(_ sender: Any) {
        if let userName = userNameTF.text, let userMail = userEmailTF.text, let userPassword = userPasswordTF
            .text {
            if userName.isEmpty || userMail.isEmpty {
                AlertManager.showAuthErrorSnackBar(vc: self, message: "Please fill all fields")
            } else {
                if userPasswordTF.text == userPasswordConfirmTF.text {
                    registerPresenterDelegate?.register(userEmail: userMail, userPassword: userPassword,userName: userName)
                } else {
                    AlertManager.showAuthErrorSnackBar(vc: self, message: "Passwords do not match")
                }
            }
        }
    }
}

extension RegisterViewController {
     func initializeHideKeyboard(){
        //Declare a Tap Gesture Recognizer which will trigger our dismissMyKeyboard() function
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissMyKeyboard))
        
        //Add this tap gesture recognizer to the parent view
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissMyKeyboard(){
        //endEditing causes the view (or one of its embedded text fields) to resign the first responder status.
        //In short- Dismiss the active keyboard.
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
            // Move the view only when the usernameTextField or the passwordTextField are being edited
            if userPasswordTF.isEditing || userPasswordConfirmTF.isEditing {
                moveViewWithKeyboard(notification: notification, viewBottomConstraint: self.passwordConfirmBottomConstraint, keyboardWillShow: true)
                rightArrowButton.isHidden = true
                leftArrowButton.isHidden = true
            }
        }
        
        @objc func keyboardWillHide(_ notification: NSNotification) {
            moveViewWithKeyboard(notification: notification, viewBottomConstraint: self.passwordConfirmBottomConstraint, keyboardWillShow: false)
            rightArrowButton.isHidden = false
            leftArrowButton.isHidden = false
        }
        
        func moveViewWithKeyboard(notification: NSNotification, viewBottomConstraint: NSLayoutConstraint, keyboardWillShow: Bool) {
            
            // Keyboard's size
            guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
            let keyboardHeight = keyboardSize.height
            
            // Keyboard's animation duration
            let keyboardDuration = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
            
            // Keyboard's animation curve
            let keyboardCurve = UIView.AnimationCurve(rawValue: notification.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! Int)!
            
            // Change the constant
            if keyboardWillShow {
                let safeAreaExists = (self.view?.window?.safeAreaInsets.bottom != 0) // Check if safe area exists
                let bottomConstant: CGFloat = 20
                viewBottomConstraint.constant = keyboardHeight / 1.5 + (safeAreaExists ? 0 : bottomConstant)
            }else {
                viewBottomConstraint.constant = 48
            }
            
            // Animate the view the same way the keyboard animates
            let animator = UIViewPropertyAnimator(duration: keyboardDuration, curve: keyboardCurve) { [weak self] in
                // Update Constraints
                self?.view.layoutIfNeeded()
            }
            
            // Perform the animation
            animator.startAnimation()
        }
 }

extension RegisterViewController : PresenterToViewRegisterProtocol {
    func showError(error: Error) {
        AlertManager.showAuthErrorSnackBar(vc: self, message: error.localizedDescription)
    }
    
    func showSuccess() {
        AlertManager.showSuccessSnackBar(vc: self, message: "Login successful, you are being redirected")
    }
}

