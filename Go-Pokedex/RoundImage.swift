//
//  RoundImage.swift
//  Instagram
//
//  Created by Ant on 4/3/16.
//  Copyright © 2016 TastyApp. All rights reserved.
//

import UIKit

class RoundImage: UIImageView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.borderWidth = 3
        self.layer.borderColor = UIColor.whiteColor().CGColor
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }

}
