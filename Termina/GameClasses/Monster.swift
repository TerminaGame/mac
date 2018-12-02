//
//  Monster.swift
//  Termina
//
//  Created by Marquis Kurt on 11/20/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

import Foundation
import SpriteKit

/**
 Base class for monsters.
 
 This class is responsible for adding the logic behind monsters when attached to SKSpriteNodes.
 */
class Monster: Entity {
    
    /**
     Power of attack (damage an entity will receive)
     */
    var attack: Int
    
    /**
     Variable that dictates ability to be pacified
     */
    var canBePacified: Bool
    
    /**
     The associated HUD from the room scene
     */
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
    
    /**
     Remove the HUD, physics body, and change the texture of the entity.
     
     This is typically used to put the monster in a pacified state, meaning that it won't attack a Player.
     */
    func pacify() {
        associatedHud.removeFromParent()
        associatedNode.physicsBody = nil
        associatedNode.texture = SKTexture(imageNamed: "PacifiedErrorNode")
        associatedHud.zPosition = -1
    }
    
    /**
     Initializes the Monster class.
     
     - Parameters:
        - myName: Name of the monster
         - myLevel: Monster's level
         - myNode: The associated node from the SKScene
         - myHealth: The default health
         - pacifiable: Whether the monster is pacifiable. Can either be "yes", "random", or "no"
         - thisHud: The associated HUD from the SKSScene
     */
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
