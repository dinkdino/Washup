//
//  PickupViewController.swift
//  Washup
//
//  Created by Hrishikesh Sawant on 08/02/15.
//  Copyright (c) 2015 Hrishikesh. All rights reserved.
//

import UIKit

class PickupViewController: UIViewController {
    
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var selectedDate: NSDate?
    var selectedTime: NSDate?
    
    @IBOutlet weak var typeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var serviceSegmentedControl: UISegmentedControl!
    
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
        
        // Segmented Controls
        self.typeSegmentedControl.setBackgroundImage(UIImage(named: "grayBg.png"), forState: UIControlState.Normal, barMetrics: UIBarMetrics.Default)
        self.typeSegmentedControl.setBackgroundImage(UIImage(named: "orangeBg.png"), forState: UIControlState.Selected, barMetrics: UIBarMetrics.Default)
        
        let font = UIFont(name: "RobotoCondensed-Bold", size: 18)!
        let titleAttributes = [ NSFontAttributeName: font, NSForegroundColorAttributeName: UIColor.whiteColor() ]
        self.typeSegmentedControl.setTitleTextAttributes(titleAttributes, forState: UIControlState.Normal)
        self.typeSegmentedControl.setTitleTextAttributes(titleAttributes, forState: UIControlState.Selected)
        self.typeSegmentedControl.layer.cornerRadius = 2.0
        self.typeSegmentedControl.clipsToBounds = true
        
        self.serviceSegmentedControl.setBackgroundImage(UIImage(named: "grayBg.png"), forState: UIControlState.Normal, barMetrics: UIBarMetrics.Default)
        self.serviceSegmentedControl.setBackgroundImage(UIImage(named: "orangeBg.png"), forState: UIControlState.Selected, barMetrics: UIBarMetrics.Default)
        
        self.serviceSegmentedControl.setTitleTextAttributes(titleAttributes, forState: UIControlState.Normal)
        self.serviceSegmentedControl.setTitleTextAttributes(titleAttributes, forState: UIControlState.Selected)
        self.serviceSegmentedControl.layer.cornerRadius = 2.0
        self.serviceSegmentedControl.clipsToBounds = true
    }

    @IBAction func backButtonTapped(sender: UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func dateWrapperTapped(sender: AnyObject) {
        
        var datePicker = ActionSheetDatePicker(title: "Date", datePickerMode: UIDatePickerMode.Date, selectedDate: NSDate(), doneBlock: { (datePicker: ActionSheetDatePicker!, date: AnyObject!, selectedValue: AnyObject!) -> Void in
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "EEEE, dd MMM YYYY"
            
            if let date = date as? NSDate {
                self.selectedDate = date
                self.dateLabel.text = dateFormatter.stringFromDate(date)
            }
            }, cancelBlock: { (datePicker: ActionSheetDatePicker!) -> Void in
            
        }, origin: self.view)
        let secondsInWeek: NSTimeInterval = 7 * 24 * 60 * 60;
        datePicker.minimumDate = NSDate(timeInterval: -secondsInWeek, sinceDate: NSDate())
        datePicker.maximumDate = NSDate(timeInterval: secondsInWeek, sinceDate: NSDate())

        datePicker.showActionSheetPicker()
    }
    
    @IBAction func timeWrapperTapped(sender: AnyObject) {
        
        var datePicker = ActionSheetDatePicker(title: "Date", datePickerMode: UIDatePickerMode.Time, selectedDate: NSDate(), doneBlock: { (datePicker: ActionSheetDatePicker!, date: AnyObject!, selectedValue: AnyObject!) -> Void in
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "hh:mm a"
            
            if let date = date as? NSDate {
                self.selectedTime = date
                self.timeLabel.text = dateFormatter.stringFromDate(date)
            }
            }, cancelBlock: { (datePicker: ActionSheetDatePicker!) -> Void in
            
        }, origin: self.view)

        datePicker.showActionSheetPicker()
    }
}
