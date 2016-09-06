//
//  SpellViewController.swift
//  Go Pokedex
//
//  Created by antoine beneteau on 02/09/2016.
//  Copyright © 2016 TastyApp. All rights reserved.
//

import UIKit

class SpellViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var chargeMovesTableView: UITableView!
    @IBOutlet weak var quickMovesTableView: UITableView!
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Table view data source
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 199 {
            return pokemon.quickMoves.count
        } else if tableView.tag == 299 {
            return pokemon.chargeMoves.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell = UITableViewCell()
        
        if tableView.tag == 199 {
            let quickMoveSorted = sortQuickMoveListStab(pokemon.quickMoves, types: pokemon.types)
            let quickMovePath = quickMoveSorted[indexPath.row]
            cell = tableView.dequeueReusableCellWithIdentifier("quickCell", forIndexPath: indexPath)
            (cell.viewWithTag(202) as! UIImageView).image = UIImage(named: "\(quickMovePath.type.name)move")
            if pokemon.types.count == 1 {
                if quickMovePath.type.name == pokemon.types[0].name {
                    (cell.viewWithTag(200) as! UILabel).text = quickMovePath.stabDps
                    (cell.viewWithTag(204)! as UIView).hidden = false
                } else {
                    (cell.viewWithTag(200) as! UILabel).text = quickMovePath.trueDps
                }
            } else if pokemon.types.count == 2 {
                if quickMovePath.type.name == pokemon.types[0].name {
                    (cell.viewWithTag(200) as! UILabel).text = quickMovePath.stabDps
                    (cell.viewWithTag(204)! as UIView).hidden = false
                } else if quickMovePath.type.name == pokemon.types[1].name {
                    (cell.viewWithTag(200) as! UILabel).text = quickMovePath.stabDps
                    (cell.viewWithTag(204)! as UIView).hidden = false
                } else {
                    (cell.viewWithTag(200) as! UILabel).text = quickMovePath.trueDps
                }
            }
            (cell.viewWithTag(205) as! UILabel).text = "\(quickMovePath.type.name) / Pow: \(quickMovePath.pow) / \(quickMovePath.cooldown)s"
            (cell.viewWithTag(201) as! UILabel).text = quickMovePath.name
        } else if tableView.tag == 299 {
            let chargeMoveSorted = sortChargeMoveListStab(pokemon.chargeMoves, types: pokemon.types)
            let chargeMovePath = chargeMoveSorted[indexPath.row]
            cell = tableView.dequeueReusableCellWithIdentifier("chargeCell", forIndexPath: indexPath)
            (cell.viewWithTag(402) as! UIImageView).image = UIImage(named: "\(chargeMovePath.type.name)move")
            if pokemon.types.count == 1 {
                if chargeMovePath.type.name == pokemon.types[0].name {
                    (cell.viewWithTag(200) as! UILabel).text = chargeMovePath.stabDps
                    (cell.viewWithTag(204)! as UIView).hidden = false
                } else {
                    (cell.viewWithTag(200) as! UILabel).text = chargeMovePath.trueDps
                }
            } else if pokemon.types.count == 2 {
                if chargeMovePath.type.name == pokemon.types[0].name {
                    (cell.viewWithTag(400) as! UILabel).text = chargeMovePath.stabDps
                    (cell.viewWithTag(404)! as UIView).hidden = false
                } else if chargeMovePath.type.name == pokemon.types[1].name {
                    (cell.viewWithTag(400) as! UILabel).text = chargeMovePath.stabDps
                    (cell.viewWithTag(404)! as UIView).hidden = false
                } else {
                    (cell.viewWithTag(400) as! UILabel).text = chargeMovePath.trueDps
                }
            }
            (cell.viewWithTag(405) as! UILabel).text = "\(chargeMovePath.type.name) / Pow: \(chargeMovePath.pow) / Crit: \(chargeMovePath.crit) \(chargeMovePath.cooldown)s"
            (cell.viewWithTag(401) as! UILabel).text = chargeMovePath.name
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 64.0
    }
    
    // MARK: Table vie delegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
    }

}
