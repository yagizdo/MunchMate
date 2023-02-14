//
//  LoginViewController.swift
//  FoodDeliveryApp
//
//  Created by Yılmaz Yağız Dokumacı on 11.02.2023.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var loginButtonTopContraint: NSLayoutConstraint!
    
    var loginPresenterDelegate : ViewToPresenterLoginProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set Textfields Left padding
        setTextfieldsLeftPadding(textfield: emailTF)
        setTextfieldsLeftPadding(textfield: passwordTF)
        
        // Keyboard extension initialized
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
        
        // Create Module
        LoginRouter.createModule(ref: self)
    }
    
    func setTextfieldsLeftPadding(textfield:UITextField) {
        textfield.setLeftPadding(10)
    }
    
    @IBAction func buttonLoginOnClick(_ sender: Any) {
        if let userMail = emailTF.text, let userPassword = passwordTF
            .text {
            if userPassword.isEmpty || userMail.isEmpty {
                AlertManager.showAuthErrorSnackBar(vc: self, message: "Please fill all fields")
            } else {
                loginPresenterDelegate?.loginWithEmailAndPassword(userEmail: userMail, userPassword: userPassword)
            }
        }
    }
    
}

extension LoginViewController {
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
            if passwordTF.isEditing {
                moveViewWithKeyboard(notification: notification, viewBottomConstraint: self.loginButtonTopContraint, keyboardWillShow: true)
            }
        }
        
        @objc func keyboardWillHide(_ notification: NSNotification) {
            moveViewWithKeyboard(notification: notification, viewBottomConstraint: self.loginButtonTopContraint, keyboardWillShow: false)
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
                viewBottomConstraint.constant = keyboardHeight / 2.5 + (safeAreaExists ? 0 : bottomConstant)
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

extension LoginViewController : PresenterToViewLoginProtocol {
    func showError(error: Error) {
        let errCode = AuthErrorCode(_nsError: error as NSError)
        AlertManager.showAuthErrorSnackBar(vc: self, message: errCode.generateErrorMessage)
    }
    
    func showSuccess() {
        AlertManager.showSuccessSnackBar(vc: self, message: "Login successful, you are being redirected")
    }
}

