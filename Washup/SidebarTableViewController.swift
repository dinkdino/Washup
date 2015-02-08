//
//  SidebarTableViewController.swift
//  Washup
//
//  Created by Hrishikesh Sawant on 08/02/15.
//  Copyright (c) 2015 Hrishikesh. All rights reserved.
//

import UIKit

class SidebarTableViewController: UITableViewController {
    
    let menuItems = [ "dashboard", "account", "logout" ]

}

extension SidebarTableViewController: UITableViewDataSource, UITableViewDelegate {
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let reuseId = menuItems[indexPath.row]
        var cell = tableView.dequeueReusableCellWithIdentifier(reuseId, forIndexPath: indexPath) as UITableViewCell
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if menuItems[indexPath.row] == "logout" {
            PFUser.logOut()
            revealViewController().dismissViewControllerAnimated(true, completion: nil)
        }
    }
}
