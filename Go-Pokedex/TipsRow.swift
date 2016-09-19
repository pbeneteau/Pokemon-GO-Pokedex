//
//  TipsRow.swift
//  Go Pokedex
//
//  Created by TastyApp on 22/08/2016.
//  Copyright © 2016 TastyApp. All rights reserved.
//

import UIKit

class TipsRow: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var imageQuickLook: RoundImage!
    @IBOutlet weak var versionLabel: UILabel!
    
    func initCell(title: String, image: UIImage, version: String) {
        self.title.text = title
        self.imageQuickLook.image = image
        self.versionLabel.text = version
    }
    
}