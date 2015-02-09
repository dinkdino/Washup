//
//  StoreLocatorViewController.swift
//  Washup
//
//  Created by Hrishikesh Sawant on 09/02/15.
//  Copyright (c) 2015 Hrishikesh. All rights reserved.
//

import UIKit

class StoreLocatorViewController: UIViewController {

    @IBOutlet weak var bgView: UIView!
    
    @IBAction func backButtonTapped(sender: UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        
        self.setupViews()
    }
    
    func setupViews() {
        
        // Gradient BG
        let bgBounds = self.bgView.bounds
        let gradient = CAGradientLayer()
        gradient.frame = bgBounds
        gradient.colors = [ UIColor(red: 235/255.0, green: 246/255.0, blue: 252/255.0, alpha: 1.0),
                            UIColor(red: 248/255.0, green: 252/255.0, blue: 1.0, alpha: 1.0) ]
        
        self.bgView.layer.addSublayer(gradient)
    }
}
