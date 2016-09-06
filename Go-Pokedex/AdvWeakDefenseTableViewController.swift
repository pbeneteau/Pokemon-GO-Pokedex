//
//  AdvWeakDefenseTableViewController.swift
//  Go Pokedex
//
//  Created by antoine beneteau on 05/09/2016.
//  Copyright © 2016 TastyApp. All rights reserved.
//

import UIKit

class AdvWeakDefenseTableViewController: UITableViewController {

    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tabForTypes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell1", forIndexPath: indexPath)
        let path = tabForTypes[indexPath.row]
        let valor = String(format:"%.2f", pokemon.defenseTypes[path]!)
        (cell.viewWithTag(500) as! UILabel).text = path
        (cell.viewWithTag(502) as! UILabel).text = "x \(valor)"
        (cell.viewWithTag(501) as! UILabel).text = "All damages are "
        if valor == "0.80" {
            (cell.viewWithTag(503)! as UIView).backgroundColor = UIColor ( red: 0.9255, green: 0.3922, blue: 0.2941, alpha: 1.0 )
        } else if valor == "1.00" {
            (cell.viewWithTag(503)! as UIView).backgroundColor = UIColor ( red: 0.3498, green: 0.4016, blue: 0.4628, alpha: 1.0 )
        } else if valor == "0.64" {
            (cell.viewWithTag(503)! as UIView).backgroundColor = UIColor ( red: 0.9373, green: 0.2824, blue: 0.2118, alpha: 1.0 )
        } else if valor == "1.25" {
            (cell.viewWithTag(503)! as UIView).backgroundColor = UIColor ( red: 0.5294, green: 0.8275, blue: 0.4863, alpha: 1.0 )
        } else if valor == "1.56" {
            (cell.viewWithTag(503)! as UIView).backgroundColor = UIColor ( red: 0.149, green: 0.7608, blue: 0.5059, alpha: 1.0 )
        }
        
        return cell
    }

}
