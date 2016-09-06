//
//  SettingsViewController.swift
//  Go Pokedex
//
//  Created by Paul Beneteau on 26/08/2016.
//  Copyright © 2016 TASTYAPP. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {

    @IBOutlet weak var notifSwitch: NSLayoutConstraint!
    @IBOutlet weak var notifLabel: UILabel!
    
    let mail = "contact.gopokedex@gmail.com"
    let twitter = "https://twitter.com/GO_Pokedex_IOS"
    let facebook = "https://www.facebook.com/gopokedexapp/"
    let rate = ""
    let www = "http://gopokedexapp.com"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // show the navigation bar
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(nil, forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.translucent = false
        self.navigationItem.title = "Settings"
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont (name: "OpenSans-Semibold", size: 19)!,  NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.tableView.allowsSelection = false
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

}
