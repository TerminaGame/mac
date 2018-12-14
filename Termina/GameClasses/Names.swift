//
//  Names.swift
//  Termina for macOS
//
//  Created by Marquis Kurt on 10/23/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

import Foundation

/**
 Generator for weapon and monster names.
 
 This class randomly picks elements from its properties to generate names. These are usually based off of kit names or typical Swift-like errors.
 */
class NameGenerator {
    
    /**
     The prefix used for weapons (NS). Mirrors APIs found in Cocoa and other Apple APIs.
     */
    let weaponPrefix = "NS"
    
    /**
     The suffix used for monsters (Error).
     */
    let monsterSuffix = "Error"
    
    /**
     An array containing all of the possible root weapon names.
     */
    let weaponList = [
        "App",
        "File",
        "Bundle",
        "Kit",
        "Implementer",
        "Object",
        "Rect",
        "Null",
        "Area",
        "Coordinate",
        "Sprite",
        "Scene",
        "Node",
        "Class",
        "Home",
        "Core",
        "Message",
        "Map",
        "Multi",
        ""
    ]
    
    /**
     An array containing all of the possible weapon suffixes.
     */
    let weaponSuffix = [
        "Delegate",
        "Manager",
        "Handler",
        "Buffer",
        "Array",
        "Service",
        "Bundle",
        "List",
        "Dictionary",
        ""
    ]
    
    /**
     An array containing all of the possible monster root names.
     */
    let monsterList = [
        "Null",
        "Integer",
        "String",
        "Format",
        "Array",
        "Guard",
        "Type",
        "Class",
        "Loop",
        "Struct",
        "Protocol",
        "JSON",
        "List",
        "Area",
        "View",
        ""
    ]
    
    /**
     An array containing all of the possible monster name modifiers.
     */
    let monsterAddition = [
        "Pointer",
        "Value",
        "Wrap",
        "Call",
        "Invalid",
        "Conversion",
        "Interrupt",
        "NotExist",
        "Exception",
        "State",
        "Loop",
        "Parse",
        "Handle",
        "Manage",
        "Display",
        ""
    ]
    
    /**
     An array of all of the possible NPC names.
     
     These are not dynamically generated like monster and weapon names and are split by gender in the code.
     */
    let namesNPC = [
        "John",
        "Manny",
        "Douglas",
        "Linus",
        "Peter",
        "Mike",
        "Aaron",
        "Daniel",
        "Samuel",
        "Henry",
        "Joseph",
        "Adam",
        "Thomas",
        "Tim",
        "Andrew",
        "Wallace",
        "Nicholas",
        "Gordon",
        "Calvin",
        "Kelvin",
        "Keith",
        "Jim",
        "Mumbo",
        "Grian",
        "Alan",
        "Martin",
        "Christopher",
        "Norman",
        "Beowulf",
        "Shane",
        "Cave",
        
        "Andromeda",
        "Michelle",
        "Alize",
        "Monique",
        "Susan",
        "Allison",
        "Amy",
        "Natalie",
        "Nova",
        "Chloe",
        "Dupris",
        "Claris",
        "Maria",
        "Leah",
        "Sarah",
        "Mia",
        "Jill",
        "Sierra",
        "Scotia",
        "Kate",
        "Caroline",
        "Catherine",
        "Mystique",
        "Chrysanthemum",
        "Monica",
        "Anna",
        "Esther",
        "Quinn",
        "Ari"
    ]
    
    /**
     Generates a weapon name from random elements of `weaponList` and `weaponSuffix` with its prefix.
     
     - Returns: Weapon name as a String
     */
    func generateWeaponName() -> String {
        return weaponPrefix + (weaponList.randomElement() ?? "") + (weaponSuffix.randomElement() ?? "")
    }
    
    /**
     Generates a monster name from random elements in `monsterList` and `monsterAddition` with its suffix.
     
     - Returns: Monster name as a String
     */
    func generateMonsterName() -> String {
        return (monsterList.randomElement() ?? "") + (monsterAddition.randomElement() ?? "") + monsterSuffix
    }
    
    /**
     Picks a name from `namesNPC` randomly.
     
     - Returns: NPC name as a String
     */
    func generateNameNPC() -> String {
        return namesNPC.randomElement() ?? "NPC"
    }
    
}
