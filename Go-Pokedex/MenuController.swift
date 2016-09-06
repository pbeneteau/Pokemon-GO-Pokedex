//
//  MenuController.swift
//  Go Pokedex
//
//  Created by antoine beneteau on 21/08/2016.
//  Copyright © 2016 TastyApp. All rights reserved.
//

import Foundation
import UIKit

func createrMenu(view: UIView) ->PathMenu{
    let menuItemImage = UIImage(named: "pokeball-1")!
    let menuItemHighlitedImage = UIImage(named: "pokeball-1")!
    
    let pokedexMenuItem = PathMenuItem(image: menuItemImage, highlightedImage: menuItemHighlitedImage, contentImage: UIImage(named: "pokedex-1")!)
    let backpackMenuItem = PathMenuItem(image: menuItemImage, highlightedImage: menuItemHighlitedImage, contentImage: UIImage(named: "backpack-1")!)
    let tipsMenuItem = PathMenuItem(image: menuItemImage, highlightedImage: menuItemHighlitedImage, contentImage: UIImage(named: "tips-1")!)
    let ivMenuItem = PathMenuItem(image: menuItemImage, highlightedImage: menuItemHighlitedImage, contentImage: UIImage(named: "IV")!)
    let settingsMenuItem = PathMenuItem(image: menuItemImage, highlightedImage: menuItemHighlitedImage, contentImage: UIImage(named: "Settings-1")!)
    
    let items = [backpackMenuItem,pokedexMenuItem,tipsMenuItem, ivMenuItem, settingsMenuItem]
    
    let startItem = PathMenuItem(image: menuItemImage,
                                 highlightedImage: menuItemImage,
                                 contentImage: menuItemImage,
                                 highlightedContentImage: menuItemImage)
    
    let menu = PathMenu(frame: view.bounds, startItem: startItem, items: items)
    menu.startPoint     = CGPointMake(UIScreen.mainScreen().bounds.width/2, UIScreen.mainScreen().bounds.height - menuItemImage.size.height * 0.65)
    menu.menuWholeAngle = CGFloat(M_PI) - CGFloat(M_PI/5)
    menu.rotateAngle    = -CGFloat(M_PI_2) + CGFloat(M_PI/5) * 1/2
    menu.timeOffset     = 0.0
    menu.farRadius      = 110.0
    menu.nearRadius     = 90.0
    menu.endRadius      = 100.0
    menu.animationDuration = 0.25
    
    view.insertSubview(menu, atIndex: 8)

    return menu
}


extension MenuViewController: PathMenuDelegate {
    func pathMenu(menu: PathMenu, didSelectIndex idx: Int) {
        switch idx {
        case 0:
            self.itemsContainer.hidden = false
            self.pokedexContainer.hidden = true
            self.tipsContainer.hidden = true
            self.ivContainer.hidden = true
            self.settingsContainer.hidden = true
        case 1:
            self.itemsContainer.hidden = true
            self.pokedexContainer.hidden = false
            self.tipsContainer.hidden = true
            self.ivContainer.hidden = true
            self.settingsContainer.hidden = true
        case 2:
            self.itemsContainer.hidden = true
            self.pokedexContainer.hidden = true
            self.tipsContainer.hidden = false
            self.ivContainer.hidden = true
            self.settingsContainer.hidden = true
        case 3:
            self.itemsContainer.hidden = true
            self.pokedexContainer.hidden = true
            self.tipsContainer.hidden = true
            self.ivContainer.hidden = false
            self.settingsContainer.hidden = true
        case 4:
            self.itemsContainer.hidden = true
            self.pokedexContainer.hidden = true
            self.tipsContainer.hidden = true
            self.ivContainer.hidden = true
            self.settingsContainer.hidden = false
        default:
            self.itemsContainer.hidden = true
            self.pokedexContainer.hidden = false
            self.tipsContainer.hidden = true
            self.ivContainer.hidden = true
            self.settingsContainer.hidden = true
        }
    }
    
    func pathMenuWillAnimateOpen(menu: PathMenu) {
        self.view.insertSubview(self.viewForBlur, atIndex: 7)
        self.viewForBlur.fadeInMenu()
    }
    
    func pathMenuWillAnimateClose(menu: PathMenu) {
        self.viewForBlur.fadeOutMenu()
    }
    
    func pathMenuDidFinishAnimationOpen(menu: PathMenu) {
    }
    
    func pathMenuDidFinishAnimationClose(menu: PathMenu) {
    }
    
    
}
