//
//  LevelView.swift
//  Go Pokedex
//
//  Created by antoine beneteau on 30/08/2016.
//  Copyright © 2016 TastyApp. All rights reserved.
//

import UIKit

class LevelModalView: UIView, UIPickerViewDataSource, UIPickerViewDelegate {

    var bottomButtonHandler: (() -> Void)?

    
    @IBOutlet weak var levelTextField: CustomUITextField!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet private weak var bottomButton: UIButton!

    var vc: IVViewController!
    var pickerView = UIPickerView()
    var levelsToPick = [String]()
    
    class func instantiateFromNib() -> LevelModalView {
        let view = UINib(nibName: "LevelModalView", bundle: nil).instantiateWithOwner(nil, options: nil).first as! LevelModalView
        
        return view
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configure()
        self.initTextField(levelTextField, pickerView: pickerView)
    }
    
    private func configure() {
        self.contentView.layer.cornerRadius = 5
    }
    
    @IBAction func handleBottomButton(sender: UIButton) {
        self.bottomButtonHandler?()
        if let text = levelTextField.text where !text.isEmpty
        {
            vc.passLevel(levelTextField.text!)
        } else {
            print("bad entry")
            vc.levelOK = false
        }
        
    }

    func initTextField(textField: UITextField, pickerView: UIPickerView) {
        pickerView.delegate = self
        pickerView.dataSource = self
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.Default
        toolBar.translucent = true
        toolBar.tintColor = UIColor(red: 101.0/255, green: 105.0/255, blue: 113.0/255, alpha: 1.0)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(LevelModalView.doneButtonAction))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.userInteractionEnabled = true
        
        textField.inputView = pickerView
        textField.inputAccessoryView = toolBar
    }
    
    func doneButtonAction()
    {
        self.levelTextField.resignFirstResponder()
        self.levelTextField.resignFirstResponder()
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return levelsToPick.count
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return levelsToPick[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        levelTextField.text = levelsToPick[row]
    }

}
