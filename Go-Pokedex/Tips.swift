//
//  tips.swift
//  Go Pokedex
//
//  Created by antoine beneteau on 22/08/2016.
//  Copyright © 2016 TastyApp. All rights reserved.
//

import UIKit

class Tips {
    private var _title: String!
    private var _img: UIImage!
    private var _date: String!
    private var _description: String!
    
    var title: String {
        return _title
    }
    
    var img: UIImage {
        return _img
    }
    
    var date: String {
        return _date
    }
    
    var description: String {
        return _description
    }
    
    init(title: String, img: UIImage,date: String, description: String) {
        self._title = title
        self._img = img
        self._date = date
        self._description = description
    }
}
