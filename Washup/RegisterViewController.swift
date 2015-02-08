//
//  RegisterViewController.swift
//  Washup
//
//  Created by Hrishikesh Sawant on 07/02/15.
//  Copyright (c) 2015 Hrishikesh. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    
    // Validation views
    @IBOutlet weak var validationMessageWrapperView: UIView!
    @IBOutlet weak var validationMessageLabel: UILabel!
    
    // Form Fields
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var mobileNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Design changes
        self.setupViews()
    }
    
    func setupViews() {
        // Corder radius for buttons
        self.submitButton.layer.cornerRadius = 2.0
    }

    @IBAction func backButtonTapped(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func submitButtonTapped(sender: UIButton!) {
        
        if !self.validateForm() {
            return
        }
        
        // Form is valid
        
        var user = PFUser()
        user.username = self.emailTextField.text
        user.password = self.passwordTextField.text
        user.email = self.emailTextField.text
        
        user["firstName"] = self.firstNameTextField.text
        user["lastName"] = self.lastNameTextField.text
        user["mobileNumber"] = self.mobileNumberTextField.text
        
        user.signUpInBackgroundWithBlock { (succeded: Bool!, error: NSError!) -> Void in
            
            if error == nil {
                // Signed up and logged in successfully
                self.performSegueWithIdentifier("registerSegue", sender: self)
            } else {
                
                if let userInfo = error.userInfo {
                    let errorString = userInfo["error"] as String
                    println(errorString)
                }
            }
        }
        
    }
    
    func validateForm() -> Bool {
        
        // First name
        if self.firstNameTextField.text.isEmpty {
            showValidationErrorMessage("Please enter a first name")
            return false
        }
        
        // Last name
        if self.lastNameTextField.text.isEmpty {
            showValidationErrorMessage("Please enter a last name")
            return false
        }
        
        // Mobile number
        if self.mobileNumberTextField.text.isEmpty {
            showValidationErrorMessage("Please enter a mobile number")
            return false
        }
        
        // Email
        if self.emailTextField.text.isEmpty {
            showValidationErrorMessage("Please enter a email address")
            return false
        }
        
        if !self.emailTextField.text.isEmailValid() {
            showValidationErrorMessage("Please enter a valid email address")
            return false
        }
        
        // Password
        if self.passwordTextField.text.isEmpty {
            showValidationErrorMessage("Please enter a password")
            return false
        }
        
        if countElements(self.passwordTextField.text) < 6 {
            showValidationErrorMessage("Password should be atleast 6 characters long")
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
    
}

extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

