//
//  ViewController.swift
//  CityGuide
//
//  Created by TastyApp on 30/12/15.
//  Copyright © 2015 TastyApp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // cover image
    @IBOutlet weak var coverImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animate()
        
    }
    
    
    func animate() {
        self.coverImage.animationImages = [
            UIImage(named: "splash_1")!,
            UIImage(named: "splash_2")!,
            UIImage(named: "splash_3")!,
            UIImage(named: "splash_4")!
        ]
        self.coverImage.animationDuration = 3.0
        self.coverImage.startAnimating()
    }
    
    override func viewWillAppear(animated: Bool) {
        // hide navigation bar
        self.navigationController?.navigationBarHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // set status bar hidden
    override func prefersStatusBarHidden() -> Bool {
        return false
    }
}

