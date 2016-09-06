//
//  Pokemon.swift
//  Go Pokedex
//
//  Created by antoine beneteau on 22/08/2016.
//  Copyright © 2016 Anna. All rights reserved.
//

import UIKit

class Pokemon {
    private var _id: String!
    private var _name: String!
    private var _img: UIImage!
    private var _typesString: [String]!
    private var _types: [Type]!
    private var _weight: String!
    private var _height: String!
    private var _attack: String!
    private var _defense: String!
    private var _stamina: String!
    private var _attackSpeed: String!
    private var _defenseSpeed: String!
    private var _speed: String!
    private var _tankiness: String!
    private var _evoIDs: [String]!
    private var _candy: String!
    private var _maxMultiplier: String!
    private var _avMultiplier: String!
    private var _minCP: String!
    private var _maxCP: String!
    private var _jumps: String!
    private var _jumpDuration: String!
    private var _baseCatch: String!
    private var _baseFlee: String!
    private var _chargeMovesString: [String]!
    private var _quickMovesString: [String]!
    private var _chargeMoves: [ChargeMove]!
    private var _quickMoves: [QuickMove]!
    private var _description: String!
    private var _attackTypes = [String:Double]()
    private var _defenseTypes = [String:Double]()
    
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
    
    var img: UIImage {
        if _img == nil {
            _img = UIImage(named: "151.png")
        }
        return _img
    }
    
    var description: String {
        if _description == nil {
            _description = "?"
        }
        return _description
    }
    
    var typesString: [String] {
        return _typesString
    }
    
    var types: [Type] {
        return _types
    }
    
    var idLbl: String {
        return "No. "+_id
    }
    
    var weight: String {
        if _weight == nil {
            _weight = "?"
        }
        return _weight
    }
    
    var height: String {
        if _height == nil {
            _height = "?"
        }
        return _height
    }
    
    var attack: String {
        if _attack == nil {
            _attack = "?"
        }
        return _attack
    }
    
    var defense: String {
        if _defense == nil {
            _defense = "?"
        }
        return _defense
    }
    
    var stamina: String {
        if _stamina == nil {
            _stamina = "?"
        }
        return _stamina
    }
    
    var attackSpeed: String {
        return _attackSpeed
    }
    var defenseSpeed: String {
        return _defenseSpeed
    }
    var speed: String {
        return _speed
    }
    
    var tankiness: String {
        return _tankiness
    }
    
    var evoIDs: [String] {
        if _evoIDs == nil {
            _evoIDs = []
        }
        return _evoIDs
    }
    
    var candy: String {
        if _candy == nil {
            _candy = ""
        }
        return _candy
    }
    
    var maxMultiplier: String {
        if _maxMultiplier == nil {
            _maxMultiplier = ""
        }
        return _maxMultiplier
    }
    
    var avMultiplier: String {
        if _avMultiplier == nil {
            _avMultiplier = ""
        }
        return _avMultiplier
    }
    
    var minCP: String {
        if _minCP == nil {
            _minCP = "?"
        }
        return _minCP
    }
    var maxCP: String {
        if _maxCP == nil {
            _maxCP = "?"
        }
        return _maxCP
    }
    var jumps: String {
        if _jumps == nil {
            _jumps = "?"
        }
        return _jumps
    }
    var jumpDuration: String {
        if _jumpDuration == nil {
            _jumpDuration = "?"
        }
        return _jumpDuration
    }
    var baseCatch: String {
        if _baseCatch == nil {
            _baseCatch = "?"
        }
        return _baseCatch
    }
    var baseFlee: String {
        if _baseFlee == nil {
            _baseFlee = "?"
        }
        return _baseFlee
    }
    
    var  chargeMoves: [ChargeMove] {
        return _chargeMoves
    }
    
    var  quickMoves: [QuickMove] {
        return _quickMoves
    }
    
    var chargeMovesString: [String] {
        return _chargeMovesString
    }
    
    var quickMovesString: [String] {
        return _quickMovesString
    }
    
    var attackTypes: [String:Double] {
        return _attackTypes
    }
    
    var defenseTypes: [String:Double] {
        return _defenseTypes
    }
    
    
    init(id: String, name: String) {
        self._id = id
        self._name = name
        self._img = UIImage(named: "\(id).png")
        self._chargeMoves = []
        self._chargeMoves.removeAll()
        self._quickMoves = []
        self._quickMoves.removeAll()
        self._types = [Type(),Type()]
        self._typesString = []
        self._typesString.removeAll()
        self._chargeMovesString = []
        self._chargeMovesString.removeAll()
        self._quickMovesString = []
        self._quickMovesString.removeAll()
        self._evoIDs = []
        self._evoIDs.removeAll()
        self._attackTypes = tabForTypesDouble
        self._defenseTypes = tabForTypesDouble
    }
    
    func initSpecies(attack: String, defense: String, stamina: String, tankiness: String, minCP: String, maxCP: String, jumps: String, jumpDuration: String, baseCatch: String, baseFlee: String, typesString: [String], chargeMovesString: [String], quickMovesString: [String], attackSpeed: String, defenseSpeed: String, speed: String) {
        self._attack = attack
        self._defense = defense
        self._stamina = stamina
        self._tankiness = tankiness
        self._minCP = minCP
        self._maxCP = maxCP
        self._jumps = jumps
        self._jumpDuration = jumpDuration
        self._baseCatch = baseCatch
        self._baseFlee = baseFlee
        self._typesString = typesString
        self._quickMovesString = quickMovesString
        self._chargeMovesString = chargeMovesString
        self._attackSpeed = attackSpeed
        self._defenseSpeed = defenseSpeed
        self._speed = speed
        self._attackTypes = tabForTypesDouble
        self._defenseTypes = tabForTypesDouble
    }
    
    func initTypes(types: [Type]) {
        self._types = [Type(),Type()]
    }
    
    func addDescription(description: String) {
        self._description = description
    }
    
    func addEvolution(evoIDs: [String], candy: String, maxMultiplier: String, avMultiplier: String) {
        self._evoIDs = evoIDs
        self._candy = candy
        self._maxMultiplier = maxMultiplier
        self._avMultiplier = avMultiplier
    }
    
    func addQuickMove(quickMove: QuickMove) {
        self._quickMoves.append(quickMove)
    }
    
    func addChargeMove(chargeMove: ChargeMove) {
        self._chargeMoves.append(chargeMove)
    }
    
    func addType(type: Type, index: Int) {
        self._types[index] = type
    }
    
    func addAttackAdvWeak(attackTypes: [String: Double]) {
        self._attackTypes = attackTypes
    }
    func addDefenseAdvWeak(defenseTypes: [String:Double]) {
        self._defenseTypes = defenseTypes
    }
    
    func multiply(type: String, stat: String, number: Double) {
        if stat == "Attack" {
            self._attackTypes[type] = self._attackTypes[type]! * number
        } else if stat == "Defense" {
            self._defenseTypes[type] = self._defenseTypes[type]! * number
        }
    }
}


func initAllPokemons() -> [Pokemon]{
    let pokemonCSV = CSVReader(fileName: "GoPokedex_SpeciesFinal")
    var pokemonList = [Pokemon]()
    pokemonList.removeAll()
    for row in pokemonCSV.rows {
        let pokemon = Pokemon(id: row["Pdex #"]!, name: row["Species Names"]!)
        let quickMovesString = [row["Standard Move 1"]!,row["Standard Move 2"]!]
        let chargeMovesString = [row["Special Move 1"]!,row["Special Move 2"]!, row["Special Move 3"]!, row["Special Move 4"]!]
        pokemon.initSpecies(row["Attack"]!, defense: row["Defense"]!, stamina: row["Stamina"]!, tankiness:  row["Tankiness"]!,minCP: row["Min IV CP Cap"]!, maxCP: row["Max IV CP Cap"]!, jumps: row["Jumps/min"]!, jumpDuration: row["Jump Duration (s)"]!, baseCatch: row["Base Catch%"]!, baseFlee: row["Base Flee%"]!, typesString: [row["Type 1"]!,row["Type 2"]!], chargeMovesString: chargeMovesString, quickMovesString: quickMovesString, attackSpeed: row["SP.ATK"]!, defenseSpeed: row["SP.DEF"]!, speed: row["SPEED"]!)
        pokemonList.append(pokemon)
    }
    return pokemonList
}

func addEvolutions(pokemonList: [Pokemon]) {
    let evolutionsCSV = CSVReader(fileName: "GoPokedex_Evolutions")
    for pokemon in pokemonList {
        for row in evolutionsCSV.rows {
            if pokemon.id == row["#"] {
                if row["Evolution #"] != ""{
                    pokemon.addEvolution([row["Evolution #"]!], candy: row["Candy"]!, maxMultiplier:  row["Max CP x"]!, avMultiplier:  row["Min CP x"]!)
                } else if row["Evolution Multiple 1"] != ""{
                    pokemon.addEvolution([row["Evolution Multiple 1"]!,row["Evolution Multiple 2"]!,row["Evolution Multiple 3"]!], candy: row["Candy"]!, maxMultiplier:  row["Max CP x"]!, avMultiplier:  row["Min CP x"]!)
                }
            }
        }
    }
}

func addDescriptions(pokemonList: [Pokemon]) {
    let descriptionsCSV = CSVReader(fileName: "GoPokedex_Descriptions")
    for pokemon in pokemonList {
        for row in descriptionsCSV.rows {
            if pokemon.id == row["#"] {
                pokemon.addDescription(row["Description"]!)
            }
        }
    }
}

func addTypes(pokemonList: [Pokemon], typeList: [Type]) {
    for pokemon in pokemonList {
        for type in typeList {
            if pokemon.typesString[0] == type.name {
                pokemon.addType(type, index: 0)
                continue
            } else if pokemon.typesString[1] == type.name {
                pokemon.addType(type, index: 1)
                continue
            }
        }
    }
}

func initAllPokemonInfos(pokemonList: [Pokemon], quickMoveList: [QuickMove], chargeMoveList: [ChargeMove], typeList: [Type]) {
    addTypes(pokemonList, typeList: typeList)
    addDescriptions(pokemonList)
    addEvolutions(pokemonList)
    addQuickMoves(pokemonList, quickMoveList: quickMoveList)
    addChargeMoves(pokemonList, chargeMoveList: chargeMoveList)
    for pokemon in pokemonList {
        getFinalAttackTypes(pokemon)
        getFinalDefenseTypes(pokemon)
    }
}

func getFinalAttackTypes(pokemon: Pokemon) {
    if pokemon.types.count == 2 {
        for a in TypesResultAttack(pokemon)[1] {
            pokemon.multiply(a, stat: "Attack", number: 0.80)
        }
        for a in TypesResultAttack(pokemon)[3] {
            pokemon.multiply(a, stat: "Attack", number: 1.25)
        }
    }
}

func getFinalDefenseTypes(pokemon: Pokemon) {
    if pokemon.types.count == 2 {
        for a in TypesResultDefense(pokemon)[1] {
            pokemon.multiply(a, stat: "Defense", number: 0.80)
        }
        for a in TypesResultDefense(pokemon)[3] {
            pokemon.multiply(a, stat: "Defense", number: 1.25)
        }
    }
}




