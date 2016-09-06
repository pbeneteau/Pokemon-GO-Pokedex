//
//  Types.swift
//  Go Pokedex
//
//  Created by antoine beneteau on 27/08/2016.
//  Copyright © 2016 Anna. All rights reserved.
//

import UIKit

class Type {
    private var _id: String!
    private var _name: String!
    private var _color: UIColor!
    private var _attack = [[String]]()
    private var _defense = [[String]]()
    
    var id: String {
        return _id
    }
    
    var name: String {
        return _name
    }
    
    var color: UIColor {
        return _color
    }
    
    var attack: [[String]] {
        return _attack
    }
    
    var defense: [[String]] {
        return _defense
    }
    
    init() {
        self._attack = [[],[],[],[]]
        self._defense = [[],[],[],[]]

        self._name = ""
        self._color = TYPES["Normal"]![1] as! UIColor
    }
    
    init(id: String, name: String) {
        self._attack = [[],[],[],[]]
        self._defense = [[],[],[],[]]
        
        self._id = id
        self._name = name
        self._color = TYPES[name]![1] as! UIColor
    }

    
    func addAttack(number: Int, types: [String]) {
        self._attack[number] = types
    }
    
    func addDefense(number: Int, types: [String]) {
        self._defense[number] = types
    }
    
}

func initAllTypes() -> [Type] {
    let typesCVS = CSVReader(fileName: "GoPokedex_TypesFinal")
    var typeList = [Type]()
    var type = Type(id: typesCVS.rows[0]["#"]!, name: typesCVS.rows[0]["Move Types"]!)
    
    var attack0 = [String]()
    var attack50 = [String]()
    var attack100 = [String]()
    var attack200 = [String]()
    
    var defense0 = [String]()
    var defense50 = [String]()
    var defense100 = [String]()
    var defense200 = [String]()
    
    typeList.removeAll()
    typeList.append(type)
    
    for row in typesCVS.rows {
        let type_ = Type(id: row["#"]!, name: row["Move Types"]!)
        if type_.name == type.name {
            if row["Attack"] == "0" {
                attack0.append(row["Species Types"]!)
            } else if row["Attack"] == "50" {
                attack50.append(row["Species Types"]!)
            } else if row["Attack"] == "100" {
                attack100.append(row["Species Types"]!)
            } else if row["Attack"] == "200" {
                attack200.append(row["Species Types"]!)
            }
            
            if row["Defense"] == "0" {
                defense0.append(row["Species Types"]!)
            } else if row["Defense"] == "50" {
                defense50.append(row["Species Types"]!)
            } else if row["Defense"] == "100" {
                defense100.append(row["Species Types"]!)
            } else if row["Defense"] == "200" {
                defense200.append(row["Species Types"]!)
            }
            
        } else {
            type.addAttack(0, types: attack0)
            type.addAttack(1, types: attack50)
            type.addAttack(2, types: attack100)
            type.addAttack(3, types: attack200)
            
            type.addDefense(0, types: defense0)
            type.addDefense(1, types: defense50)
            type.addDefense(2, types: defense100)
            type.addDefense(3, types: defense200)
            
            attack0.removeAll()
            attack50.removeAll()
            attack100.removeAll()
            attack200.removeAll()
            
            defense0.removeAll()
            defense50.removeAll()
            defense100.removeAll()
            defense200.removeAll()
            
            type = type_
            typeList.append(type)
        }
    }
    return typeList
}

func TypesResultAttack(pokemon: Pokemon) -> [[String]] {
    var result = [[String]]()
    var tab0 = tabForTypesAdvWeak
    var tab50 = tabForTypesAdvWeak
    var tab100 = tabForTypesAdvWeak
    var tab200 = tabForTypesAdvWeak
    var res0 = [String]()
    var res50 = [String]()
    var res100 = [String]()
    var res200 = [String]()
    
    if pokemon.types.count == 1 {
        result = pokemon.types[0]._attack
    } else {
        // 0%
        for a in pokemon.types[0]._attack[0] {
            tab0[a]! += 1
        }
        for b in pokemon.types[1]._attack[0] {
            tab0[b]! += 1
        }
        // 50%
        for a in pokemon.types[0]._attack[1] {
            tab50[a]! += 1
        }
        for b in pokemon.types[1]._attack[1] {
            tab50[b]! += 1
        }
        // 100%
        for a in pokemon.types[0]._attack[2] {
            tab100[a]! += 1
        }
        for b in pokemon.types[1]._attack[2] {
            tab100[b]! += 1
        }
        // 200%
        for a in pokemon.types[0]._attack[3] {
            tab200[a]! += 1
        }
        for b in pokemon.types[1]._attack[3] {
            tab200[b]! += 1
        }
        
        // Result 0%
        for type in tabForTypes {
            if tab0[type] == 1 {
                res0.append(type)
            } else if tab0[type] > 1 {
                res0.append(type)
                res0.append(type)
            }
        }
        // Result 50%
        for type in tabForTypes {
            if tab50[type] == 1 {
                res50.append(type)
            } else if tab50[type] > 1 {
                res50.append(type)
                res50.append(type)
            }
        }
        // Result 100%
        for type in tabForTypes {
            if tab100[type] == 1 {
                res100.append(type)
            } else if tab100[type] > 1 {
                res100.append(type)
                res100.append(type)
            }
        }
        // Result 200%
        for type in tabForTypes {
            if tab200[type] == 1 {
                res200.append(type)
            } else if tab200[type] > 1 {
                res200.append(type)
                res200.append(type)
            }
        }
        
        result = [res0,res50,res100,res200]
    }
    
    return result
}

func TypesResultDefense(pokemon: Pokemon) -> [[String]] {
    var result = [[String]]()
    var tab0 = tabForTypesAdvWeak
    var tab50 = tabForTypesAdvWeak
    var tab100 = tabForTypesAdvWeak
    var tab200 = tabForTypesAdvWeak
    var res0 = [String]()
    var res50 = [String]()
    var res100 = [String]()
    var res200 = [String]()
    
    if pokemon.types.count == 1 {
        result = pokemon.types[0]._defense
    } else {
        // 0%
        for a in pokemon.types[0]._defense[0] {
            tab0[a]! += 1
        }
        for b in pokemon.types[1]._defense[0] {
            tab0[b]! += 1
        }
        // 50%
        for a in pokemon.types[0]._defense[1] {
            tab50[a]! += 1
        }
        for b in pokemon.types[1]._defense[1] {
            tab50[b]! += 1
        }
        // 100%
        for a in pokemon.types[0]._defense[2] {
            tab100[a]! += 1
        }
        for b in pokemon.types[1]._defense[2] {
            tab100[b]! += 1
        }
        // 200%
        for a in pokemon.types[0]._defense[3] {
            tab200[a]! += 1
        }
        for b in pokemon.types[1]._defense[3] {
            tab200[b]! += 1
        }
        
        // Result 0%
        for type in tabForTypes {
            if tab0[type] == 1 {
                res0.append(type)
            } else if tab0[type] > 1 {
                res0.append(type)
                res0.append(type)
            }
        }
        // Result 50%
        for type in tabForTypes {
            if tab50[type] == 1 {
                res50.append(type)
            } else if tab50[type] > 1 {
                res50.append(type)
                res50.append(type)
            }
        }
        // Result 100%
        for type in tabForTypes {
            if tab100[type] == 1 {
                res100.append(type)
            } else if tab100[type] > 1 {
                res100.append(type)
                res100.append(type)
            }
        }
        // Result 200%
        for type in tabForTypes {
            if tab200[type] == 1 {
                res200.append(type)
            } else if tab200[type] > 1 {
                res200.append(type)
                res200.append(type)
            }
        }
        
        result = [res0,res50,res100,res200]
    }
    return result
}




