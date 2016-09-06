//
//  IVViewController.swift
//  Go Pokedex
//
//  Created by antoine beneteau on 28/08/2016.
//  Copyright © 2016 TastyApp. All rights reserved.
//

import UIKit
import QuartzCore


class IVViewController: UIViewController , UITableViewDelegate, UITableViewDataSource, hpModalViewProtocol, cpModalViewProtocol, UISearchBarDelegate {
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var pokemonImage: UIButton!
    @IBOutlet weak var hpLabel: UILabel!
    @IBOutlet weak var stardustLabel: UILabel!
    @IBOutlet weak var cpLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    
    @IBOutlet weak var resultsMainView: UIView!
    @IBOutlet weak var noCombinaisonLabel2: UILabel!
    @IBOutlet weak var noCombinaisonLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var poweredLabel: UILabel!
    
    @IBOutlet weak var poweredSwitchView: UIView!
    @IBOutlet weak var attackDefenseIv: UILabel!
    @IBOutlet weak var staminaIv: UILabel!
    @IBOutlet weak var battleRatingPerCent: UILabel!
    @IBOutlet weak var cpRatingPerCent: UILabel!
    @IBOutlet weak var hpPerCent: UILabel!
    
    @IBOutlet weak var searchBar: UISearchBar!
    var filteredPokemons = Array<Pokemon>()
    var inSearchMode = false
    
    let mySwitch = SevenSwitch()
    var powered: Bool = false
    var selectedPokemon: Pokemon!
    
    var pickerViewStardust = UIPickerView()
    var pickerViewLevel = UIPickerView()
    
    var levels = [String]()
    var IVs = [IVstruct]()
    var hp = 53
    var cp = 504
    var stardust = 3000
    var level = "21.0"
    
    var hpOK: Bool! = true
    var cpOK: Bool! = true
    var stardustOK: Bool! = true
    var levelOK: Bool! = true
    var levelCanBePressed = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSwitch()
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont (name: "OpenSans-Bold", size: 21)!,  NSForegroundColorAttributeName: UIColor.whiteColor()]
    }
    override func viewDidAppear(animated: Bool) {
        self.selectedPokemon = pokemonList[3]
        initSearch()
        self.pokemonImage.hidden = true
        self.hideAllStats(true)
        self.reloadDatas()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initSearch() {
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.Done
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.text = ""
        view.endEditing(true)
        searchBar.showsCancelButton = false
        filteredPokemons = pokemonList
        self.tableView.reloadData()
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            view.endEditing(true)
            self.tableView.reloadData()
        } else {
            inSearchMode = true
            let lowercaseString = searchBar.text!.lowercaseString
            filteredPokemons = pokemonList.filter({(($0.name).lowercaseString.rangeOfString(lowercaseString) != nil)})
            self.tableView.reloadData()
        }
    }
    
    func reloadDatas() {
        if hpOK && cpOK && stardustOK {
            self.hpLabel.text = "\(self.hp)"
            self.cpLabel.text = "\(self.cp)"
            self.stardustLabel.text = "\(self.stardust)"
            self.levelLabel.text = "\(self.level)"
            loadIVsForLevel()
        }
    }
    
    func loadIVsForLevel() {
        if hpOK && cpOK && stardustOK && levelOK {
            self.hideAllStats(false)
            self.IVs = evaluate(self.selectedPokemon, cp: self.cp, hp: self.hp, dust: self.stardust, powered: powered)
            if self.IVs.count == 0 {
                self.noCombinaisonLabel.hidden = false
                self.noCombinaisonLabel2.hidden = false
                self.hideAllStats(true)
                self.resultsMainView.hidden = true
            } else {
                self.resultsMainView.hidden = false
                self.noCombinaisonLabel.hidden = true
                self.noCombinaisonLabel2.hidden = true
                self.hideAllStats(false)
                for iv in IVs {
                    if iv.level == self.level {
                        self.attackDefenseIv.text = "\(iv.attackIV + iv.defenseIV)"
                        self.staminaIv.text = "\(iv.staminaIV)"
                        self.battleRatingPerCent.text = "\(determinePerfectionBattle(iv))%"
                        self.hpPerCent.text = "\(determinePerfectionHp(iv))%"
                        self.cpRatingPerCent.text = "\(determinePerfection(iv))%"
                    }
                }
            }
        }
    }
    
    func hideAllStats(hide: Bool) {
        self.attackDefenseIv.hidden = hide
        self.staminaIv.hidden = hide
        self.battleRatingPerCent.hidden = hide
        self.cpRatingPerCent.hidden = hide
        self.hpPerCent.hidden = hide
    }
    
    func initSwitch() {
        mySwitch.addTarget(self, action: #selector(IVViewController.switchChanged(_:)), forControlEvents: UIControlEvents.ValueChanged)
        mySwitch.offImage = UIImage(named: "cross.png")
        mySwitch.onImage = UIImage(named: "check.png")
        mySwitch.thumbImage = UIImage(named: "thumb.png")
        mySwitch.offLabel.text = ""
        mySwitch.onLabel.text = ""
        mySwitch.thumbTintColor = UIColor(red: 0.19, green: 0.23, blue: 0.33, alpha: 1)
        mySwitch.activeColor =  UIColor(red: 0.07, green: 0.09, blue: 0.11, alpha: 1)
        mySwitch.inactiveColor =  UIColor(red: 0.07, green: 0.09, blue: 0.11, alpha: 1)
        mySwitch.onTintColor =  UIColor(red: 0.45, green: 0.58, blue: 0.67, alpha: 1)
        mySwitch.borderColor = UIColor.clearColor()
        mySwitch.shadowColor = UIColor.blackColor()
        
        mySwitch.frame = poweredSwitchView.bounds
        mySwitch.isRounded = false
        poweredSwitchView.addSubview(mySwitch)
    }
    
    @IBAction func addButtonPressed(sender: AnyObject) {
        self.tableView.hidden = false
        self.navigationItem.title = "Choose your pokemon"
        self.tableView.reloadData()
    }
    @IBAction func pokemonPressed(sender: AnyObject) {
        self.tableView.hidden = false
        self.tableView.reloadData()
        self.navigationItem.title = "Choose your pokemon"
    }
    
    
    func switchChanged(sender: SevenSwitch) {
        if powered {
            powered = false
            poweredLabel.layer.shadowColor = UIColor(red:0.60, green:0.58, blue:0.58, alpha:1.0).CGColor
            poweredLabel.layer.shadowRadius = 0
            poweredLabel.layer.shadowOpacity = 0
            poweredLabel.layer.masksToBounds = false
            poweredLabel.textColor = UIColor(red:0.60, green:0.58, blue:0.58, alpha:1.0)
            self.level = findLevels(self.stardust, powered: powered)[0]
            self.reloadDatas()
        } else {
            powered = true
            poweredLabel.layer.shadowColor = UIColor(red:0.18, green:0.80, blue:0.44, alpha:1.0).CGColor
            poweredLabel.layer.shadowRadius = 4.0
            poweredLabel.layer.shadowOpacity = 0.9
            poweredLabel.layer.shadowOffset = CGSizeZero
            poweredLabel.layer.masksToBounds = false
            poweredLabel.textColor = UIColor(red:0.18, green:0.80, blue:0.44, alpha:1.0)
            self.level = findLevels(self.stardust, powered: powered)[0]
            self.reloadDatas()
        }
    }
    
    @IBAction func hpPressed(sender: AnyObject) {
        let view = HpModalView.instantiateFromNib()
        let window = UIApplication.sharedApplication().delegate?.window!
        let modal = PathDynamicModal()
        view.vc = self
        view.hpTextField.text = "\(self.hp)"
        modal.showMagnitude = 200.0
        modal.closeMagnitude = 130.0
        view.bottomButtonHandler = {[weak modal] in
            modal?.closeWithLeansRandom()
            return
        }
        modal.show(modalView: view, inView: window!)
    }
    @IBAction func cpPressed(sender: AnyObject) {
        let view = CpModalView.instantiateFromNib()
        let window = UIApplication.sharedApplication().delegate?.window!
        let modal = PathDynamicModal()
        view.vc = self
        view.cpTextField.text = "\(self.cp)"
        modal.showMagnitude = 200.0
        modal.closeMagnitude = 130.0
        view.bottomButtonHandler = {[weak modal] in
            modal?.closeWithLeansRandom()
            return
        }
        modal.show(modalView: view, inView: window!)
    }
    @IBAction func stardustPressed(sender: AnyObject) {
        let view = StardustModalView.instantiateFromNib()
        let window = UIApplication.sharedApplication().delegate?.window!
        let modal = PathDynamicModal()
        view.vc = self
        view.pickerView.selectRow(self.stardust, inComponent: 0, animated: true)
        view.stardustTextField.text = "\(self.stardust)"
        modal.showMagnitude = 200.0
        modal.closeMagnitude = 130.0
        view.bottomButtonHandler = {[weak modal] in
            modal?.closeWithLeansRandom()
            return
        }
        modal.show(modalView: view, inView: window!)
    }
    @IBAction func levelPressed(sender: AnyObject) {
        if  levelCanBePressed {
            let view = LevelModalView.instantiateFromNib()
            let window = UIApplication.sharedApplication().delegate?.window!
            let modal = PathDynamicModal()
            view.vc = self
            view.levelsToPick = findLevels(self.stardust, powered: powered)
            view.levelTextField.text = (findLevels(self.stardust, powered: powered))[0]
            view.pickerView.selectRow(0, inComponent: 0, animated: true)
            modal.showMagnitude = 200.0
            modal.closeMagnitude = 130.0
            view.bottomButtonHandler = {[weak modal] in
                modal?.closeWithLeansRandom()
                return
            }
            modal.show(modalView: view, inView: window!)
        } else {
            print("Can't choose level now")
        }
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if inSearchMode {
            return filteredPokemons.count
        } else {
            return pokemonList.count
        }
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        var pokemonCopy: Pokemon
        if inSearchMode {
            pokemonCopy = filteredPokemons[indexPath.row]
        } else {
            pokemonCopy = pokemonList[indexPath.row]
        }
        
        (cell.viewWithTag(100) as! UIImageView).image = pokemonCopy.img
        (cell.viewWithTag(101) as! UILabel).text = pokemonCopy.name
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if inSearchMode {
            self.selectedPokemon = filteredPokemons[indexPath.row]
            self.pokemonImage.setImage(filteredPokemons[indexPath.row].img, forState: .Normal)
        } else {
            self.selectedPokemon = pokemonList[indexPath.row]
            self.pokemonImage.setImage(pokemonList[indexPath.row].img, forState: .Normal)
        }
        
        self.pokemonImage.hidden = false
        self.addButton.hidden = true
        self.tableView.hidden = true
        self.navigationItem.title = selectedPokemon.name
        reloadDatas()
        searchBar.text = ""
        view.endEditing(true)
        searchBar.showsCancelButton = false
        filteredPokemons = pokemonList
        self.tableView.reloadData()
    }
    
    func passHp(hp: Int) {
        self.hp = hp
        self.hpOK = true
        reloadDatas()
    }
    
    func passCp(cp: Int) {
        self.cp = cp
        self.cpOK = true
        reloadDatas()
    }
    
    func passStardust(stardust: Int) {
        self.stardust = stardust
        self.stardustOK = true
        self.levelCanBePressed = true
        self.level = findLevels(self.stardust, powered: powered)[0]
        reloadDatas()
    }
    
    func passLevel(level: String) {
        self.level = level
        self.levelOK = true
        reloadDatas()
    }
    
}
