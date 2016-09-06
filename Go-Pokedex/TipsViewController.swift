//
//  TipsViewController.swift
//  Go Pokedex
//
//  Created by antoine beneteau on 22/08/2016.
//  Copyright © 2016 TastyApp. All rights reserved.
//

import UIKit
import CloudKit

class TipsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var tipsRecords = Array<CKRecord>()
    var tips = [Tips]()
    var selectedTips: Int!
    // set the cursor
    var theCursor:CKQueryCursor!
    var loadMoreOk: Bool = false
    var animated = false
    var activityIndicator: NVActivityIndicatorView!
    
    override func viewDidLoad() {
        initActivityIndicator()
        super.viewDidLoad()
        // show the navigation bar
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(nil, forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.translucent = false
        self.navigationItem.title = "ChangeLogs"
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont (name: "OpenSans-Semibold", size: 19)!,  NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Pokemon Solid", size: 14)!], forState: UIControlState.Normal)
        
        
        //createTips()
        loadTips()
    }
    
    func initActivityIndicator() {
        self.activityIndicator = NVActivityIndicatorView(frame: CGRectMake(0, 0, 80, 80))
        self.activityIndicator.center = CGPointMake(self.view.frame.width/2, self.view.frame.height/2 - activityIndicator.frame.height/2)
        self.activityIndicator.type = NVActivityIndicatorType.BallClipRotatePulse
        self.activityIndicator.color = UIColor(red:0.91, green:0.30, blue:0.24, alpha:1.0)
        self.tableView.addSubview(activityIndicator)
        self.activityIndicator.startAnimation()
    }
    
    func initTips() {
        tips.removeAll()
        for tipsRecord in tipsRecords {
            tips.append(Tips(title: tipsRecord["title"] as! String, img: UIImage(named: "1")! /*UIImage(named: "\(tipsRecord["image"] as! String)")!*/, date: tipsRecord["date"] as! String, description: tipsRecord["description"] as! String))
        }
        self.tableView.reloadData()
        self.activityIndicator.stopAnimation()
    }
    
    func loadTips(){
        
        let publicDB = CKContainer.defaultContainer().publicCloudDatabase
        var counter: Int = 0
        
        let container = CKContainer.defaultContainer()
        
        let predicate = NSPredicate(value: true)
        let sort = NSSortDescriptor(key: "id", ascending: false)
        var newInfo = Array<CKRecord>()
        
        let query = CKQuery(recordType: "tipsInfo", predicate:  predicate)
        query.sortDescriptors = [sort]
        
        let queryOperation = CKQueryOperation(query: query)
        queryOperation.queuePriority = .VeryHigh
        queryOperation.resultsLimit = 50;
        
        self.tipsRecords.removeAll()
        // Fetch the pokemons for the record
        func fetched(record: CKRecord!) {
            self.tipsRecords.append(record)
            counter += 1
        }
        
        queryOperation.recordFetchedBlock = fetched
        
        queryOperation.queryCompletionBlock = { [unowned self] (cursor, error) in
            if (error != nil) {
                dispatch_async(dispatch_get_main_queue()) {
                    //self.connectionErrorButton.hidden = false
                    //self.activityIndicator.stopAnimation()
                    return
                }
            } else {
                dispatch_async(dispatch_get_main_queue()) {
                    print("All records fetched")
                    if counter == queryOperation.resultsLimit {
                        self.loadMoreOk = true
                    }
                    if (cursor != nil) {
                        self.theCursor = cursor
                        print("more to fetch...")
                        self.loadMoreTips()
                    } else {
                        self.initTips()
                        //self.activityIndicator.stopAnimation()
                    }
                    return
                }
            }
        }
        publicDB.addOperation(queryOperation)
    }
    
    func loadMoreTips() {
        
        let publicDB = CKContainer.defaultContainer().publicCloudDatabase
        var counter: Int = 0
        
        let queryOperation = CKQueryOperation(cursor: theCursor)
        queryOperation.resultsLimit = 50
        queryOperation.qualityOfService = .UserInteractive
        
        func fetched(record: CKRecord!) {
            self.tipsRecords.append(record)
            counter += 1
        }
        
        queryOperation.recordFetchedBlock = fetched
        
        queryOperation.queryCompletionBlock = {
            cursor, error in
            
            if (error != nil) {
                dispatch_async(dispatch_get_main_queue()) {
                    return
                }
            } else {
                dispatch_async(dispatch_get_main_queue()) {
                    print("All records fetched")
                    if counter != queryOperation.resultsLimit {
                        self.loadMoreOk = false
                    }
                    if (cursor != nil) {
                        self.theCursor = cursor
                        self.loadMoreTips()
                    } else {
                        self.initTips()
                        //self.activityIndicator.stopAnimation()
                    }
                    return
                }
            }
        }
        
        publicDB.addOperation(queryOperation)
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let numberOfSections = tableView.numberOfSections
        let tableHeight: CGFloat = tableView.bounds.size.height
        var index = 0
        
        if !animated {
            for i in 0...numberOfSections - 1 {
                let numberOfCells = tableView.numberOfRowsInSection(i)
                
                for j in 0...numberOfCells - 1 {
                    if (indexPath.section == i && indexPath.row == j) {
                        cell.transform = CGAffineTransformMakeTranslation(0, tableHeight)
                        UIView.animateWithDuration(1.0, delay: 0.05 * Double(index),usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
                            cell.transform = CGAffineTransformMakeTranslation(0, 0);
                            }, completion: nil)
                    }
                    index += 1
                }

            }
            animated = true
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return tips.count
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TipsRow") as! TipsRow
        cell.initCell(tips[indexPath.section].title, image: tips[indexPath.section].img)
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectedTips = indexPath.section
        performSegueWithIdentifier("TipsDetailSegue", sender: self)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "TipsDetailSegue" {
            print(selectedTips)
            (segue.destinationViewController as! TipsDetailViewController).tips = tips[selectedTips]
            (segue.destinationViewController as! TipsDetailViewController).tipsNumber = selectedTips + 1
        }
    }
    
}
