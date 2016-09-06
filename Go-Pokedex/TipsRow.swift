//
//  TipsRow.swift
//  Go Pokedex
//
//  Created by antoine beneteau on 22/08/2016.
//  Copyright © 2016 TastyApp. All rights reserved.
//

import UIKit

class TipsRow: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var imageQuickLook: RoundImage!
    
    func initCell(title: String, image: UIImage) {
        self.title.text = title
        self.imageQuickLook.image = image
    }
    
}