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
    
    @IBOutlet weak var scrollView: UIScrollView!
    // Form Fields
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var mobileNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var submitButton: UIButton!
    
    var activeTextField: UITextField!
    
    var delegate: RegisterViewControllerDelegate?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.registerKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.deregisterKeyboardNotifications()
    }
    
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
                self.dismissViewControllerAnimated(false, completion: nil)
                self.delegate?.registeredSuccessfully()
            } else {
                
                if let userInfo = error.userInfo {
                    let errorString = userInfo["error"] as String
                    self.showValidationErrorMessage("Could not create new account. Try Again.")
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
    
    func textFieldDidBeginEditing(textField: UITextField) {
        self.activeTextField = textField
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        self.activeTextField = nil
    }
    
    func registerKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardDidShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardDidHideNotification, object: nil)
    }
    
    func deregisterKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardDidShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardDidHideNotification, object: nil)
    }
    
    func keyboardWillShow(notification:NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            
            if let textField = self.activeTextField {
                let frame = textField.convertRect(textField.frame, toView: nil)
                let origin = frame.origin
                let height = textField.frame.size.height
                
                var visibleRect = self.view.frame
                visibleRect.size.height -= keyboardSize.height
                
                if !CGRectContainsPoint(visibleRect, origin) {
                    let scrollToPoint = CGPoint(x: 0.0, y: origin.y - visibleRect.size.height + height)
                    scrollView.setContentOffset(scrollToPoint, animated: true)
                }
                
            }
        }
    }
    
    func keyboardWillHide(notification:NSNotification) {
        scrollView.setContentOffset(CGPointZero, animated: true)
    }
}


protocol RegisterViewControllerDelegate {
    func registeredSuccessfully()
}

