//
//  TipsHeaderView.swift
//  Go Pokedex
//
//  Created by antoine beneteau on 22/08/2016.
//  Copyright © 2016 TastyApp. All rights reserved.
//

import UIKit
import Foundation

class TipsHeaderView: UITableViewHeaderFooterView {
    @IBOutlet weak var imageMin: RoundImage!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var view: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.titleLabel.textColor = UIColor.whiteColor()
        self.titleLabel.font = UIFont(name: "OpenSans-Semibold", size: 19.0)!
    }
    
    func initView(imageMin: UIImage, title: String, date: String) {
        self.imageMin.image = imageMin
        self.titleLabel.text = title
        self.dateLabel.text = date
    }

}
