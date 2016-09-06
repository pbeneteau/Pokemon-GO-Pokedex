//
//  TipsDetailViewController.swift
//  Go Pokedex
//
//  Created by antoine beneteau on 22/08/2016.
//  Copyright © 2016 TastyApp. All rights reserved.
//

import UIKit
import CloudKit

class TipsDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var tips: Tips!
    var tipsNumber: Int!
    // set the cursor
    var theCursor:CKQueryCursor!
    var loadMoreOk: Bool = false
    var animated = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // show the navigation bar
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(nil, forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.translucent = false
        self.navigationItem.title = "ChangeLog \(tips.date)"
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont (name: "OpenSans-Semibold", size: 19)!,  NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Pokemon Solid", size: 14)!], forState: UIControlState.Normal)
        
        let nib = UINib(nibName: "TipsHeaderView", bundle: nil)
        tableView.registerNib(nib, forHeaderFooterViewReuseIdentifier: "TipsHeaderView")
    }
    
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 188
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = self.tableView.dequeueReusableHeaderFooterViewWithIdentifier("TipsHeaderView") as! TipsHeaderView
        header.initView(self.tips.img, title: self.tips.title, date: self.tips.date)
        return header
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TipsDescription") as! TipsDescription
        cell.initDescription(self.tips.description)
        return cell
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 300
    }
    
}
