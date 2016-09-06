//
//  quickMovesViewController.swift
//  Go Pokedex
//
//  Created by antoine beneteau on 14/08/2016.
//  Copyright © 2016 TastyApp. All rights reserved.
//

import UIKit
import CloudKit

class quickMovesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var pokemon:Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // table view, number of rows
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemon.quickMoves.count
    }
    
    // table view, create each cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // create a categories cell
        let cell = tableView.dequeueReusableCellWithIdentifier("moves", forIndexPath: indexPath)
        // set its title
        let pokemonQuickMove = pokemon.quickMoves[indexPath.row]
            (cell.viewWithTag(1)! as UIView).backgroundColor = pokemonQuickMove.type.color
            (cell.viewWithTag(2)! as UIView).backgroundColor = pokemonQuickMove.type.color
            (cell.viewWithTag(5) as! UILabel).text = "\(pokemonQuickMove.type.name) / POW: \(pokemonQuickMove.pow) / \(pokemonQuickMove.cooldown)s"
            (cell.viewWithTag(7)?.hidden = false)

        (cell.viewWithTag(3) as! UILabel).text = pokemonQuickMove.trueDps
        (cell.viewWithTag(4) as! UILabel).text = pokemonQuickMove.name
        
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            cell.contentView.alpha = 1
        })

        // return the cell
        return cell
    }
    
    // table view, set height for cell
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 40
    }
    

}
