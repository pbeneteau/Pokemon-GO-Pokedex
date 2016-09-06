//
//  StardustModalView.swift
//  Go Pokedex
//
//  Created by antoine beneteau on 30/08/2016.
//  Copyright © 2016 TastyApp. All rights reserved.
//

import UIKit

class StardustModalView: UIView, UIPickerViewDelegate, UIPickerViewDataSource {

    var bottomButtonHandler: (() -> Void)?
    
    

    @IBOutlet weak var stardustTextField: CustomUITextField!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet private weak var bottomButton: UIButton!
    
    var vc: IVViewController!
    var pickerView = UIPickerView()
    
    class func instantiateFromNib() -> StardustModalView {
        let view = UINib(nibName: "StardustModalView", bundle: nil).instantiateWithOwner(nil, options: nil).first as! StardustModalView
        
        return view
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configure()
        self.initTextField(stardustTextField, pickerView: pickerView)
    }
    
    private func configure() {
        self.contentView.layer.cornerRadius = 5.0
    }
    
    @IBAction func handleBottomButton(sender: UIButton) {
        self.bottomButtonHandler?()
        if let text = stardustTextField.text where !text.isEmpty
        {
            vc.passStardust(Int(stardustTextField.text!)!)
        } else {
            print("bad entry")
            vc.stardustOK = true
            vc.levelCanBePressed = false
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
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(HpModalView.doneButtonAction))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.userInteractionEnabled = true
        
        textField.inputView = pickerView
        textField.inputAccessoryView = toolBar
    }
    
    func doneButtonAction()
    {
        self.stardustTextField.resignFirstResponder()
        self.stardustTextField.resignFirstResponder()
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stardustOption.count
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return stardustOption[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        stardustTextField.text = stardustOption[row]
    }

}
