//
//  ItemsViewController.swift
//  Go Pokedex
//
//  Created by antoine beneteau on 25/08/2016.
//  Copyright © 2016 TastyApp. All rights reserved.
//

import UIKit

class ItemsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var itemimageView: UIImageView!
    var pickerView: UIPickerView!
    var pickerData: [String] = [String]()
    var selectorView: UIView!
    
    let height = UIScreen.mainScreen().bounds.height / 3.28323699
    let width = UIScreen.mainScreen().bounds.width / 2.44274809
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // show the navigation bar
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(nil, forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.translucent = false
        self.navigationItem.title = "Items"
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont (name: "OpenSans-Semibold", size: 19)!,  NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        self.pickerView = UIPickerView()
        self.selectorView = UIView()
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        
        initPicker()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initPicker() {
        
        self.pickerView.frame = CGRect(x: screenWidth - width, y: 0, width: width, height: height)
        self.view.insertSubview(pickerView, atIndex: 1)
        
        pickerData = ["Poke Ball", "Great Ball", "Ultra Ball", "Master Ball", "Potion", "Super Potion", "Hyper Potion", "Max Potion", "Revive", "Max Revive", "Lucky Egg", "Incense", "Lure Module", "Razz Berry", "Camera", "Incubator (infinite)", "Incubator (normal)", "Bag Upgrade", "Pokemon Storage Plus"]
        
        let heightForSelector = self.pickerView.rowSizeForComponent(0).height * 1.1
        self.selectorView.layer.borderWidth = 2
        self.selectorView.clipsToBounds = true
        self.selectorView.backgroundColor = UIColor.clearColor()
        self.selectorView.layer.borderColor = UIColor(red:0.91, green:0.33, blue:0.29, alpha:1.0).CGColor
        self.selectorView.frame = CGRect(x: 0, y: height/2 - heightForSelector/2, width: width, height: heightForSelector)
        self.pickerView.addSubview(selectorView)
    }
    
    
    // The number of columns of data
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.itemimageView.image = UIImage(named: pickerData[row])
        self.pickerView.reloadAllComponents()
    }
    
}
