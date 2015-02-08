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
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController!.navigationBarHidden = true
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController!.navigationBarHidden = false
        super.viewWillDisappear(animated)
    }
    
    override func viewDidLoad() {
        
        self.setupViews()
    }
    
    func setupViews() {
        
        
        
    }

    @IBAction func sidebarButtonTapped(sender: UIBarButtonItem) {
        revealViewController().revealToggleAnimated(true)
    }
}
