//
//  ServicesViewController.swift
//  Washup
//
//  Created by Hrishikesh Sawant on 09/02/15.
//  Copyright (c) 2015 Hrishikesh. All rights reserved.
//

import UIKit

class ServicesViewController: UIViewController {

    @IBOutlet weak var bgView: UIView!
    var services: [PFObject] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func backButtonTapped(sender: UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        
        self.setupViews()
        
        self.loadServices();
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
    
    func loadServices() {
        let query = PFQuery(className: "Services");
        query.findObjectsInBackgroundWithBlock { (result: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                self.services = result as [PFObject]
                
                self.tableView.reloadData()
                
            } else {
                println("Failed to load services.")
            }
        }
    }
}

extension ServicesViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return services.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let reuseId = "servicesCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseId, forIndexPath: indexPath) as ServicesTableViewCell
        
        // Get service for row
        let service = services[indexPath.row]
        
        cell.nameLabel.text = service["name"] as? String
        
        return cell
    }
}
