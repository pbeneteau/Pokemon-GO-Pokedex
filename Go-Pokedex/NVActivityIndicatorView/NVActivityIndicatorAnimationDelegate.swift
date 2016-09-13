//
//  NVActivityIndicatorDelegate.swift
//  NVActivityIndicatorViewDemo
//
//  Created by TastyApp on 7/23/15.
//  Copyright (c) 2015 TastyApp. All rights reserved.
//

import UIKit

protocol NVActivityIndicatorAnimationDelegate {
    func setUpAnimationInLayer(layer: CALayer, size: CGSize, color: UIColor)
}
