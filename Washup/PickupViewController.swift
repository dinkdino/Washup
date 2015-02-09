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
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var activeTextField: UITextField!
    
    var selectedDate: NSDate?
    var selectedTime: NSDate?
    
    @IBOutlet weak var typeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var serviceSegmentedControl: UISegmentedControl!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.registerKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.deregisterKeyboardNotifications()
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

extension PickupViewController: UITextFieldDelegate {
    
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