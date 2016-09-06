//
//  QuickMove.swift
//  Go Pokedex
//
//  Created by antoine beneteau on 23/08/2016.
//  Copyright © 2016 Anna. All rights reserved.
//

import UIKit


class QuickMove {
    private var _id: String!
    private var _name: String!
    private var _typeString: String!
    private var _type: Type!
    private var _damage: String!
    private var _cooldown: String!
    private var _trueDps: String!
    private var _rawDps: String!
    private var _stabDps: String!
    private var _defTrueDps: String!
    private var _defRawDps: String!
    private var _defStabDps: String!
    private var _energy: String!
    private var _energyPerSecond: String!
    private var _pow: String!
    
    
    var id: String {
        if _id == nil {
            _id = "?"
        }
        return _id
    }
    
    var name: String {
        if _name == nil {
            _name = "?"
        }
        return _name.capitalizedString
    }
    
    var type: Type {
        return _type
    }
    
    var typeString: String {
        return _typeString
    }
    
    
    var damage: String {
        if _damage == nil {
            _damage = "?"
        }
        return _damage
    }
    
    var cooldown: String {
        if _cooldown == nil {
            _cooldown = "?"
        }
        return _cooldown
    }
    
    var trueDps: String {
        if _trueDps == nil {
            _trueDps = "?"
        }
        return _trueDps
    }
    
    var rawDps: String {
        if _rawDps == nil {
            _rawDps = "?"
        }
        return _rawDps
    }
    
    var stabDps: String {
        if _stabDps == nil {
            _stabDps = "?"
        }
        return _stabDps
    }
    var defTrueDps: String {
        if _defTrueDps == nil {
            _defTrueDps = "?"
        }
        return _defTrueDps
    }
    
    var defRawDps: String {
        if _defRawDps == nil {
            _defRawDps = "?"
        }
        return _defRawDps
    }
    
    var defStabDps: String {
        if _defStabDps == nil {
            _defStabDps = "?"
        }
        return _defStabDps
    }
    
    var energy: String {
        if _energy == nil {
            _energy = "?"
        }
        return _energy
    }
    
    var energyPerSecond: String {
        if _energyPerSecond == nil {
            _energyPerSecond = "?"
        }
        return _energyPerSecond
    }
    
    var pow: String {
        if _pow == nil {
            _pow = "?"
        }
        return _pow
    }

    
    init() {
        self._type = Type()
    }
    
    init(id: String, name: String) {
        self._id = id
        self._name = name
        self._type = Type()
    }
    
    func initSpecies(damage: String, cooldown: String, trueDps: String, rawDps: String, stabDps: String, defTrueDps: String, defRawDps: String, defStabDps: String, energy: String, energyPerSecond: String, pow: String, typeString: String) {
        self._damage = damage
        self._cooldown = cooldown
        self._trueDps = trueDps
        self._rawDps = rawDps
        self._stabDps = stabDps
        self._defTrueDps = defTrueDps
        self._defRawDps = defRawDps
        self._defStabDps = defStabDps
        self._energy = energy
        self._energyPerSecond = energyPerSecond
        self._pow = pow
        self._typeString = typeString
    }
    
    func addType(type: Type) {
        self._type = type
    }
    
}

func initAllQuickMoves() -> [QuickMove]{
    let quickMovesCSV = CSVReader(fileName: "GoPokedex_QuickMovesFinal")
    var quickMovesList = [QuickMove]()
    quickMovesList.removeAll()
    for row in quickMovesCSV.rows {
        let quickMove = QuickMove(id: row["Id"]!, name: row["Name"]!)
        quickMove.initSpecies(row["Damage"]!, cooldown: row["Duration"]!, trueDps: row["True DPS"]!, rawDps: row["Raw DPS"]!, stabDps: row["STAB DPS"]!, defTrueDps: row["DEF TRUE DPS"]!, defRawDps: row["DEF Raw DPS"]!, defStabDps: row["DEF STAB DPS"]!, energy: row["Energy Gen"]!, energyPerSecond: row["Energy Gen/s"]!, pow: row["Pow"]!, typeString: row["Type"]!)
        quickMovesList.append(quickMove)
    }
    return quickMovesList
}

func addTypes(quickMoveList: [QuickMove], typeList: [Type]) {
    for quickMove in quickMoveList {
        for type in typeList {
            if quickMove.typeString == type.name {
                quickMove.addType(type)
                continue
            }
        }
    }
}


func addQuickMoves(pokemonList: [Pokemon], quickMoveList: [QuickMove]) {
    for pokemon in pokemonList {
        for quickMoveString in pokemon.quickMovesString {
            for quickMove in quickMoveList {
                if quickMoveString == quickMove.name{
                    pokemon.addQuickMove(quickMove)
                    continue
                }
            }
        }
    }
}


func sortQuickMoveList(quickMoveList1: [QuickMove]) -> [QuickMove]{
    var sortedList = quickMoveList1
    sortedList.sortInPlace({ convertStringToFloat($0.trueDps) > convertStringToFloat($1.trueDps) })
    
    return sortedList
}

func sortQuickMoveListStab(quickMoveList1: [QuickMove], types: [Type])-> [QuickMove] {
    var sortedList = quickMoveList1
    sortedList.sortInPlace({ (quickMove1: QuickMove, quickMove2: QuickMove)-> Bool in
        if types.count == 2 {
            if quickMove1.type.name == types[0].name || quickMove1.type.name == types[1].name{
                if quickMove2.type.name == types[0].name || quickMove2.type.name == types[1].name{
                    return convertStringToFloat(quickMove1.stabDps) > convertStringToFloat(quickMove2.stabDps)
                } else {
                    return convertStringToFloat(quickMove1.stabDps) > convertStringToFloat(quickMove2.trueDps)
                }
            } else if quickMove2.type.name == types[0].name || quickMove2.type.name == types[1].name{
                return convertStringToFloat(quickMove1.trueDps) > convertStringToFloat(quickMove2.stabDps)
            } else {
                return convertStringToFloat(quickMove1.trueDps) > convertStringToFloat(quickMove2.trueDps)
            }
        } else {
            if types.count == 1 {
                if quickMove1.type.name == types[0].name{
                    if quickMove2.type.name == types[0].name{
                        return convertStringToFloat(quickMove1.stabDps) > convertStringToFloat(quickMove2.stabDps)
                    } else {
                        return convertStringToFloat(quickMove1.stabDps) > convertStringToFloat(quickMove2.trueDps)
                    }
                } else if quickMove2.type.name == types[0].name{
                    return convertStringToFloat(quickMove1.trueDps) > convertStringToFloat(quickMove2.stabDps)
                } else {
                    return convertStringToFloat(quickMove1.trueDps) > convertStringToFloat(quickMove2.trueDps)
                }
            }
        }
        return convertStringToFloat(quickMove1.trueDps) > convertStringToFloat(quickMove2.trueDps)
    })
    
    return sortedList
}

