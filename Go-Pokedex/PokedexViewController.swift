//
//  pokedexViewController.swift
//  Go Pokedex
//
//  Created by antoine beneteau on 20/08/2016.
//  Copyright © 2016 TastyApp. All rights reserved.
//

import UIKit

class PokedexViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ////////////////START RATE MY APP/////////////////
        
        var iMinSessions = 3
        
        // func start
        func showRateMe() {
            let alert = UIAlertController(title: "Rate us!", message: "Thanks for using GO Pokedex", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Rate our app", style: UIAlertActionStyle.Default, handler: { alertAction in
                NSUserDefaults.standardUserDefaults().setBool(true, forKey: "neverRate")
                UIApplication.sharedApplication().openURL(NSURL(string : "itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=<iTUNES CONNECT APP ID>")!)
                alert.dismissViewControllerAnimated(true, completion: nil)
            }))
            alert.addAction(UIAlertAction(title: "No Thanks", style: UIAlertActionStyle.Default, handler: { alertAction in
                NSUserDefaults.standardUserDefaults().setBool(true, forKey: "neverRate")
                alert.dismissViewControllerAnimated(true, completion: nil)
            }))
            alert.addAction(UIAlertAction(title: "Maybe Later", style: UIAlertActionStyle.Default, handler: { alertAction in
                NSUserDefaults.standardUserDefaults().setBool(true, forKey: "maybeLater")
                alert.dismissViewControllerAnimated(true, completion: nil)
            }))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        // func end
        
        let maybeLater = NSUserDefaults.standardUserDefaults().boolForKey("maybeLater")
        let neverRate = NSUserDefaults.standardUserDefaults().boolForKey("neverRate")
        var numLaunches = NSUserDefaults.standardUserDefaults().integerForKey("numLaunches") + 1
        
        
        if (numLaunches == iMinSessions)
        {
            showRateMe()
            numLaunches = 0
        }
        else if (neverRate) {
            numLaunches = 4
        }
        else if (maybeLater) {
            numLaunches = 0
            NSUserDefaults.standardUserDefaults().setBool(false, forKey: "maybeLater")
        }
        
        NSUserDefaults.standardUserDefaults().setInteger(numLaunches, forKey: "numLaunches")
        
        ////////////////END RATE MY APP/////////////////
    }
    
    override func viewWillAppear(animated: Bool) {
        // show the navigation bar
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(nil, forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.translucent = false
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationItem.title = "Pokedex"
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont (name: "Pokemon Solid", size: 21)!,  NSForegroundColorAttributeName: UIColor.whiteColor()]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
