//
//  DashboardViewController.swift
//  Washup
//
//  Created by Hrishikesh Sawant on 08/02/15.
//  Copyright (c) 2015 Hrishikesh. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {
    
    @IBOutlet weak var sidebarButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        
        self.navigationController!.navigationBarHidden = true
        self.setupViews()
    }
    
    func setupViews() {
        
        
        
    }

    @IBAction func sidebarButtonTapped(sender: UIBarButtonItem) {
        revealViewController().revealToggleAnimated(true)
    }
}
