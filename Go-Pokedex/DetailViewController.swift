//
//  DetailViewController.swift
//  CityGuide
//
//  Created by Anna on 31/12/15.
//  Copyright © 2015 TastyApp. All rights reserved.
//

import UIKit
import MapKit
import GoogleMobileAds

class DetailViewController: UITableViewController, GADInterstitialDelegate {
    
    var pokemon: Pokemon!
    
    
    // Header
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var jumpsMinLabel: UILabel!
    @IBOutlet weak var jumpsDurationLabel: UILabel!
    
    // Rarety
    @IBOutlet weak var baseCatchLabel: UILabel!
    @IBOutlet weak var baseFleeLabel: UILabel!
    
    // CP
    @IBOutlet weak var cpMaxProgressView: UIProgressView!
    @IBOutlet weak var cpMinProgressView: UIProgressView!
    @IBOutlet weak var cpMaxLabel: UILabel!
    @IBOutlet weak var cpMinLabel: UILabel!
    
    
    @IBOutlet weak var attackProgressView: UIProgressView!
    @IBOutlet weak var defenseProgressView: UIProgressView!
    @IBOutlet weak var staminaProgressView: UIProgressView!
    @IBOutlet weak var tankinessProgressView: UIProgressView!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var staminaLabel: UILabel!
    @IBOutlet weak var tankinessLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initGeneralStats()
    }
    

    
    override func viewWillAppear(animated: Bool) {
    }
    
    override func viewWillDisappear(animated: Bool) {
        // set the alpha of the navigation bar back to 1
        self.navigationController?.navigationBar.alpha = 1
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0
    }
    
    func initGeneralStats() {
        // DESCRIPTION
        self.weightLabel.text = "Weight: \(pokemon.weight)kg"
        self.heightLabel.text = "Height: \(pokemon.height)m"
        self.jumpsMinLabel.text = "Jumps/min: \(pokemon.jumps) jumps"
        self.jumpsDurationLabel.text = "Jumps duration: \(pokemon.jumpDuration)s"
        // RARETY
        self.baseCatchLabel.text = pokemon.baseFlee
        self.baseFleeLabel.text = pokemon.baseCatch
        // CP
            // Label
        self.cpMinLabel.text = "CP- \(pokemon.minCP)"
        self.cpMaxLabel.text = "CP+ \(pokemon.maxCP)"
            // Progress
        self.cpMinProgressView.progress = 152/Float(pokemon.minCP)!
        self.cpMaxProgressView.progress = Float(pokemon.maxCP)!/4145
            // Color
        self.cpMinProgressView.progressTintColor = UIColor(red:0.94, green:0.28, blue:0.21, alpha:1.0)
        self.cpMaxProgressView.progressTintColor = UIColor(red:0.18, green:0.80, blue:0.44, alpha:1.0)
        
        // STATS
            // Labels
        self.attackLabel.text = pokemon.attack
        self.defenseLabel.text = pokemon.defense
        self.staminaLabel.text = pokemon.stamina
        self.tankinessLabel.text = pokemon.tankiness
            // Labels
        self.attackProgressView.progress = Float(pokemon.attack)!/284
        self.defenseProgressView.progress = Float(pokemon.defense)!/242
        self.staminaProgressView.progress = Float(pokemon.stamina)!/500
        self.tankinessProgressView.progress = Float(pokemon.tankiness)!/290
            // Color
        self.attackProgressView.progressTintColor = UIColor(red:0.96, green:0.14, blue:0.35, alpha:1.0)
        self.defenseProgressView.progressTintColor = UIColor(red:0.96, green:0.14, blue:0.35, alpha:1.0)
        self.staminaProgressView.progressTintColor = UIColor(red:0.96, green:0.14, blue:0.35, alpha:1.0)
        self.tankinessProgressView.progressTintColor = UIColor(red:0.96, green:0.14, blue:0.35, alpha:1.0)
    }
    

}






