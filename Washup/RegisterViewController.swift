//
//  RegisterViewController.swift
//  Washup
//
//  Created by Hrishikesh Sawant on 07/02/15.
//  Copyright (c) 2015 Hrishikesh. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
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
}

extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

