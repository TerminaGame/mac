//
//  Monster.swift
//  Termina
//
//  Created by Marquis Kurt on 11/20/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

import Foundation
import SpriteKit

class Monster: Entity {
    
    var attack: Int
    var canBePacified: Bool
    
    var associatedHud: HUD
    
    override func takeDamage(_ amount: Int) {
        let damageChance = Int.random(in: 0...10)
        if damageChance > 2 {
            super.takeDamage(amount)
            associatedHud.updateHealth(health)
        }
        if health == 0 {
            associatedHud.removeFromParent()
        }
    }
    
    func pacify() {}
    
    init(myName: String, myLevel: Int, myNode: SKSpriteNode, myHealth: Int, pacifiable: String, thisHud: HUD) {
        attack = myLevel + 5
        
        canBePacified = false
        if pacifiable == "yes" {
            canBePacified = true
        } else if pacifiable == "random" {
            if (Int.random(in: 0...5) > 4) {
                canBePacified = true
            }
        } else {
            canBePacified = false
        }
        
        associatedHud = thisHud
        
        super.init(thisName: myName, thisLevel: myLevel, defaultHealth: myHealth, thisNode: myNode)
        
        associatedHud.update(newHealth: health, newLevel: level, newName: name)
        
    }
    
}
