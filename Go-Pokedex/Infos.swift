//
//  Infos.swift
//  Go Pokedex
//
//  Created by antoine beneteau on 01/09/2016.
//  Copyright © 2016 TastyApp. All rights reserved.
//

import UIKit

class Infos: UIViewController {
    
    var pokemon: Pokemon!

    @IBOutlet weak var descriptionText: UITextView!
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.descriptionText.text = pokemon.description
        self.descriptionText.font = UIFont(name: "OpenSans-Light", size: 14.0)!
        self.descriptionText.textColor = UIColor.whiteColor()
        self.descriptionText.textAlignment = .Natural
        self.descriptionText.selectable = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "generalDetailsSegue" {
            (segue.destinationViewController as! DetailViewController).pokemon = self.pokemon
        }
    }

}
