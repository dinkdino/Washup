//
//  LoginController.swift
//  Washup
//
//  Created by Hrishikesh Sawant on 06/02/15.
//  Copyright (c) 2015 Hrishikesh. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var scrollViewWrapperTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var formWrapper: UIView!
    
    @IBOutlet weak var validationMessageWrapperView: UIView!
    @IBOutlet weak var validationMessageLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Design Changes
        self.setupViews()
    }
    
    func setupViews() {
        
        // Corder radius for buttons
        self.loginButton.layer.cornerRadius = 2.0
        self.registerButton.layer.cornerRadius = 2.0
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Reset logo position
        self.scrollViewWrapperTopConstraint.constant = 158
        
        // Hide formwrapper view
        self.formWrapper.alpha = 0.0
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
        // Animate logo upwards
        self.scrollViewWrapperTopConstraint.constant -= 100
        self.view.setNeedsUpdateConstraints()
        
        UIView.animateWithDuration(1.0, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.view.layoutIfNeeded()
            }, completion: { finished in
                UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                    self.formWrapper.alpha = 1.0
                }, completion: nil)
        })
    }
    
    @IBAction func loginButtonTapped(sender: UIButton) {
        
        if !self.validateForm() {
            return
        }
        
        PFUser.logInWithUsernameInBackground(self.usernameTextField.text, password: self.passwordTextField.text) { (user: PFUser!, error: NSError!) -> Void in
            
            if user != nil {
                self.showDashboard()
            } else {
                if let userInfo = error.userInfo {
                    let errorString = userInfo["error"] as String
                    self.showValidationErrorMessage("Incorrect email or password")
                }
            }
        }
    }
    
    func validateForm() -> Bool {
        
        // Email
        if self.usernameTextField.text.isEmpty {
            showValidationErrorMessage("Please enter a email address")
            return false
        }
        
        if !self.usernameTextField.text.isEmailValid() {
            showValidationErrorMessage("Please enter a valid email address")
            return false
        }
        
        // Password
        if self.passwordTextField.text.isEmpty {
            showValidationErrorMessage("Please enter a password")
            return false
        }
        
        // --- Form is Valid
        self.validationMessageWrapperView.hidden = true
        
        return true
    }
    
    func showValidationErrorMessage(message: String) {
        
        if !message.isEmpty {
            self.validationMessageLabel.text = message
            self.validationMessageWrapperView.hidden = false
        }
    }
    
    func showDashboard() {
        self.performSegueWithIdentifier("loginSegue", sender: self)
    }
    
    @IBAction func registerButtonTapped(sender: UIButton) {
        self.performSegueWithIdentifier("registerSegue", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "registerSegue" {
            let destinationVc = segue.destinationViewController as RegisterViewController
            destinationVc.delegate = self
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

extension LoginViewController: RegisterViewControllerDelegate {
    
    func registeredSuccessfully() {
        self.showDashboard()
    }
}

