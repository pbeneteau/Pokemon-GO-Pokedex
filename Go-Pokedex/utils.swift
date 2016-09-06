//
//  utils.swift
//  Go Pokedex
//
//  Created by antoine beneteau on 21/08/2016.
//  Copyright © 2016 Anna. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func fadeIn(duration: NSTimeInterval = 1.5, delay: NSTimeInterval = 0.0, completion: ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
        self.fadeOut()
        UIView.animateWithDuration(duration, delay: delay, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.alpha = 1.0
            }, completion: completion)  }
    
    func fadeInMenu(duration: NSTimeInterval = 0.25, delay: NSTimeInterval = 0.0, completion: ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
        self.fadeOut()
        UIView.animateWithDuration(duration, delay: delay, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.alpha = 1.0
            }, completion: completion)  }
    
    func fadeOut(duration: NSTimeInterval = 0.0, delay: NSTimeInterval = 0.0, completion: (Bool) -> Void = {(finished: Bool) -> Void in}) {
        UIView.animateWithDuration(duration, delay: delay, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.alpha = 0.0
            }, completion: completion)
    }
    
    func fadeOutMenu(duration: NSTimeInterval = 0.35, delay: NSTimeInterval = 0.0, completion: (Bool) -> Void = {(finished: Bool) -> Void in}) {
        UIView.animateWithDuration(duration, delay: delay, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.alpha = 0.0
            }, completion: completion)
    }
    
}

class CustomUITextField: UITextField {
    override func canPerformAction(action: Selector, withSender sender: AnyObject?) -> Bool {
        if action == #selector(NSObject.paste(_:)) {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
    }
}

extension UIImageView {
    func hide() {
        self.hidden = true
    }
    
    func unHide() {
        self.hidden = false
    }
}

func convertStringToFloat(string: String) -> Float{
    return NSString(string: string).floatValue
}

extension Double {
    func roundToPlaces(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return round(self * divisor) / divisor
    }
}

func roundToPlaces(value:Double, places:Int) -> Double {
    let divisor = pow(10.0, Double(places))
    return round(value * divisor) / divisor
}

