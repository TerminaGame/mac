//
//  Player.swift
//  Termina
//
//  Created by Marquis Kurt on 11/19/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

import Foundation
import SpriteKit

class Player: Entity {
    var currentInventory = [Item]()
    
    var patchNumber: Int
    var temporaryLevel: Int
    
    var associatedHud: HUD
    
    override func takeDamage(_ amount: Int) {
        super.takeDamage(amount)
        associatedHud.updateHealth(health)
        
        if health == 0 {
            associatedHud.removeFromParent()
        }
    }
    
    override func levelUp(_ amount: Int) {
        super.levelUp(amount)
        associatedHud.updateLevel(level)
    }
    
    func patchUp(_ amount: Int) {
        let temporaryPatch = patchNumber + amount
        if temporaryPatch >= 25 {
            levelUp(1)
            patchNumber = temporaryPatch - 25
        } else { patchNumber = temporaryPatch }
    }
    
    init(name: String, playerNode: SKSpriteNode, playerHud: HUD) {
        //Pre super-init
        patchNumber = 0
        temporaryLevel = 0
        associatedHud = playerHud
        
        super.init(thisName: name, thisLevel: 10, defaultHealth: 100, thisNode: playerNode)
        
        //Post super-init
        associatedHud.update(newHealth: health, newLevel: level, newName: name)
    }
    
}
