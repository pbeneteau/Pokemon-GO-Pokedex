//
//  TipsCell.swift
//  Go Pokedex
//
//  Created by antoine beneteau on 22/08/2016.
//  Copyright © 2016 TastyApp. All rights reserved.
//

import UIKit
import Foundation

class TipsDescription: UITableViewCell {
    @IBOutlet weak var descriptionText: UITextView!
    
    func initDescription(description: String) {
        self.descriptionText.text = description
        self.descriptionText.font = UIFont(name: "OpenSans-Light", size: 17.0)!
        self.descriptionText.textAlignment = .Natural
        self.descriptionText.selectable = false
    }
    
}
