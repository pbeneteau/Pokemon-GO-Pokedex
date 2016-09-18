//
//  SettingsViewController.swift
//  Go Pokedex
//
//  Created by TastyApp on 26/08/2016.
//  Copyright © 2016 TASTYAPP. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {
    
    @IBOutlet weak var popView: UIView!
    @IBOutlet var tableview: UITableView!
    @IBOutlet weak var notifSwitchLabel: UILabel!
    
    let mail = "contact.gopokedex@gmail.com"
    let twitter = "https://twitter.com/GO_Pokedex_IOS"
    let facebook = "https://www.facebook.com/gopokedexapp/"
    let rate = ""
    let www = "http://gopokedexapp.com"
    var notifCounter: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // show the navigation bar
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(nil, forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.translucent = false
        self.navigationItem.title = "Settings"
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont (name: "OpenSans-Semibold", size: 19)!,  NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.tableView.allowsSelection = false
        self.tableview.separatorInset.left = 30
        
        popView.hidden = true
        popView.layer.cornerRadius = 5;
        popView.layer.masksToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func mailPressed(sender: AnyObject) {
        let url = NSURL(string: "mailto:\(self.mail)")
        UIApplication.sharedApplication().openURL(url!)
    }

    @IBAction func twitterPressed(sender: AnyObject) {
        let url = NSURL(string: twitter)
        UIApplication.sharedApplication().openURL(url!)
    }
    
    @IBAction func facebookpressed(sender: AnyObject) {
        let url = NSURL(string: facebook)
        UIApplication.sharedApplication().openURL(url!)
    }
    
    @IBAction func websitePressed(sender: AnyObject) {
        let url = NSURL(string: www)
        UIApplication.sharedApplication().openURL(url!)
    }
    
    @IBAction func ratePressed(sender: AnyObject) {
        let url = NSURL(string: rate)
        UIApplication.sharedApplication().openURL(url!)
    }
    @IBAction func buttonClick(sender: AnyObject) {
        if notifCounter == 1 {
            notifSwitchLabel.text = "OFF"
            notifCounter = 0
            // 0: OFF
            // 1: ON
        } else if notifCounter == 0 {
            notifSwitchLabel.text = "ON"
            notifCounter = 1
        }
        popView.hidden = false
        popView.alpha = 0
        updateShow()
        let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 1 * Int64(NSEC_PER_SEC))
        dispatch_after(time, dispatch_get_main_queue()) {
            self.updateHide()
        }
        
    }
    
    func updateHide() {
        //  PopUpView.hidden = true
        UIView.animateWithDuration(0.5, delay: 1.5, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.popView.alpha = 0.0
            }, completion: nil)
        
    }
    
    func updateShow() {
        //  PopUpView.hidden = false
        UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.popView.alpha = 1.0
            }, completion: nil)
        
    }
    
    

}
