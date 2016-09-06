//
//  IvCalculator.swift
//  Go Pokedex
//
//  Created by antoine beneteau on 27/08/2016.
//  Copyright © 2016 Anna. All rights reserved.
//

import UIKit

struct IVstruct {
    var attackIV: Int
    var defenseIV: Int
    var staminaIV: Int
    var level: String
    
    init() {
        attackIV = 0
        defenseIV = 0
        staminaIV = 0
        level = ""
    }
}

struct FinalIV {
    var attackIV = 0.0
    var defenseIV = 0.0
    var staminaIV = 0.0
    var level = ""
}

struct hpIVstruct {
    var staminaIV: Int
    var level: String
    init() {
        staminaIV = 0
        level = ""
    }
}

func findLevels(stardust: Int, powered: Bool) ->[String] {
    if powered {
        return levelPoweredDictionary[stardust]!
    }
    return levelDictionary[stardust]!
}

func getCpMultiplier(level: String) -> Double{
    return cpMultiplier[level]!
}

func testHpIv(hp: Int, iv: Int, multiplier: Double, pokemon: Pokemon) -> Bool{
    return hp == Int(floor(Double((Int(pokemon.stamina)! + iv)) * multiplier))
}

func determinePerfection(IV: IVstruct) -> Double{
    let perfection = Double(IV.attackIV + IV.defenseIV + IV.staminaIV) / 45.0
    return floor(perfection * 100)
}

func determinePerfectionBattle(IV: IVstruct) -> Double{
    let perfection = Double(IV.attackIV + IV.defenseIV) / 30.0
    return floor(perfection * 100)
}

func determinePerfectionHp(IV: IVstruct) -> Double{
    let perfection = Double(IV.staminaIV) / 15.0
    return floor(perfection * 100)
}

func testCP(cp: Int, attackIV: Int, defenseIV: Int, staminaIV: Int, cpMultiplier: Double, pokemon: Pokemon) -> Bool{
    let attackFactor = Double(Int(pokemon.attack)! + attackIV)
    let defenseFactor = pow(Double(pokemon.defense)! + Double(defenseIV), 0.5)
    let staminaFactor = pow(Double(pokemon.stamina)! + Double(staminaIV), 0.5)
    let scalarFactor = pow(cpMultiplier, 2);
    return cp == Int(attackFactor * defenseFactor * staminaFactor * scalarFactor / 10)
}

func determinePossibleIVs(pokemon: Pokemon, dust: Int, cp: Int, hp: Int, powered: Bool) -> [[IVstruct]]{
    let levels = findLevels(dust, powered: powered)
    // OK
    var staminaIV = 0
    var potentialsHpIVs = [[hpIVstruct]]()
    var possible: Bool = false
    potentialsHpIVs.removeAll()
    for level in levels {
        let cpMultiplier = getCpMultiplier(level)
        var levelHpIVs = [hpIVstruct]()
        levelHpIVs.removeAll()
        // OK
        for i in 0...15 {
            if testHpIv(hp, iv: i, multiplier: cpMultiplier, pokemon: pokemon) {
                var hpIV = hpIVstruct()
                hpIV.staminaIV = i
                hpIV.level = level
                levelHpIVs.append(hpIV)
            }
        }
        potentialsHpIVs.append(levelHpIVs)
    }
    
    var potentialsIVs = [[IVstruct]]()
    potentialsIVs.removeAll()
    for hpIVblock in potentialsHpIVs {
        var levelsIVs = [IVstruct]()
        levelsIVs.removeAll()
        for hpIV in hpIVblock {
            staminaIV = hpIV.staminaIV
            let cpMultiplier1 = getCpMultiplier(hpIV.level)
            for a in 0...15 {
                for b in 0...15 {
                    if testCP(cp, attackIV: a, defenseIV: b, staminaIV: staminaIV, cpMultiplier: cpMultiplier1, pokemon: pokemon) {
                        var IV = IVstruct()
                        IV.attackIV = a
                        IV.defenseIV = b
                        IV.staminaIV = staminaIV
                        IV.level = hpIV.level
                        levelsIVs.append(IV)
                        possible = true
                    }
                }
            }
        }
        potentialsIVs.append(levelsIVs)
    }
    if !possible {
        print("No combinaison")
        return []
    }
    
    return potentialsIVs
}


func evaluate(pokemon: Pokemon, cp: Int, hp: Int, dust: Int, powered: Bool)-> [IVstruct] {
    let potentialIVs = determinePossibleIVs(pokemon, dust: dust, cp: cp, hp: hp, powered: powered)
    if potentialIVs.count == 0 {
        print("No combinaison")
    } else {
        return averageIvsPerLevel(potentialIVs)
    }
    return []
}

func averageIvsPerLevel(potentialsIVs: [[IVstruct]]) -> [IVstruct] {
    var finalPotentialsIVs = [IVstruct]()
    finalPotentialsIVs.removeAll()
    for block in potentialsIVs {
        if block.count != 0 {
            var  IV = FinalIV()
            var IVint = IVstruct()
            var count = 0.0
            for iv in block {
                IV.attackIV += Double(iv.attackIV)
                IV.defenseIV += Double(iv.defenseIV)
                IV.staminaIV += Double(iv.staminaIV)
                IV.level = iv.level
                count += 1.0
            }
            IV.attackIV /= count
            IV.defenseIV /= count
            IV.staminaIV /= count
            
            IVint.attackIV = Int(round(IV.attackIV))
            IVint.defenseIV = Int(round(IV.defenseIV))
            IVint.staminaIV = Int(round(IV.staminaIV))
            IVint.level = IV.level
            
            finalPotentialsIVs.append(IVint)
        }
    }
    return finalPotentialsIVs
}



