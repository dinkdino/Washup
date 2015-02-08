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
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var formWrapper: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Design Changes
        self.setupViews()
    }
    
    func setupViews() {
        
        // Corder radius for buttons
        self.submitButton.layer.cornerRadius = 2.0
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
    
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

