//
//  MenuViewController.swift
//  Go Pokedex
//
//  Created by antoine beneteau on 25/08/2016.
//  Copyright © 2016 TastyApp. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    let blurEffectMenu = UIBlurEffect(style: .Dark)
    let blurViewMenu = UIVisualEffectView(frame:CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height))
    let viewForBlur = UIView()
    
    @IBOutlet weak var pokedexContainer: UIView!
    @IBOutlet weak var tipsContainer: UIView!
    @IBOutlet weak var itemsContainer: UIView!
    @IBOutlet weak var settingsContainer: UIView!
    @IBOutlet weak var ivContainer: UIView!
    
    
    override func viewDidLoad() {
        blurViewMenu.effect = blurEffectMenu
        let menu = createrMenu(self.view)
        menu.delegate = self
        viewForBlur.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height)
        viewForBlur.backgroundColor = UIColor.clearColor()
        viewForBlur.addSubview(blurViewMenu)
        
        pokedexContainer.hidden = false
        tipsContainer.hidden = true
        itemsContainer.hidden = true
        settingsContainer.hidden = true
        ivContainer.hidden = true
    }
}
