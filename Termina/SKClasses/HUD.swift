//
//  HUD.swift
//  Termina
//
//  Created by Marquis Kurt on 11/20/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

import Foundation
import SpriteKit

/**
 Heads-up display that reflects level information and current health of an entity
 */
class HUD: SKNode {
    
    /**
     Updates the health number and respective graphic to an amount.
     
     - Parameters:
        - number: The number to update the HUD's health to
     */
    func updateHealth(_ number: Int) {
        let healthHudBackground = childNode(withName: "healthHudDisplay") as? SKSpriteNode
        let healthHudLabel = childNode(withName: "healthHudNumber") as? SKLabelNode
        healthHudLabel?.fontName = NSFont.boldSystemFont(ofSize: 48).fontName
        
        healthHudLabel?.text = String(number)
        
        let fadeOut = SKAction.fadeAlpha(to: 0.0, duration: 0.5)
        let fadeIn = SKAction.fadeAlpha(to: 1.0, duration: 0.5)
        
        
        healthHudBackground?.run(fadeOut)
        healthHudBackground?.alpha = 0.0
        if number > 90 {
            healthHudBackground?.run(SKAction.setTexture(SKTexture(imageNamed: "100")))
        } else if number > 80 {
            healthHudBackground?.run(SKAction.setTexture(SKTexture(imageNamed: "90")))
        } else if number > 70 {
            healthHudBackground?.run(SKAction.setTexture(SKTexture(imageNamed: "80")))
        } else if number > 60 {
            healthHudBackground?.run(SKAction.setTexture(SKTexture(imageNamed: "70")))
        } else if number > 50 {
            healthHudBackground?.run(SKAction.setTexture(SKTexture(imageNamed: "60")))
        } else if number > 40 {
            healthHudBackground?.run(SKAction.setTexture(SKTexture(imageNamed: "50")))
        } else if number > 30 {
            healthHudBackground?.run(SKAction.setTexture(SKTexture(imageNamed: "40")))
        } else if number > 20 {
            healthHudBackground?.run(SKAction.setTexture(SKTexture(imageNamed: "30")))
        } else if number > 10 {
            healthHudBackground?.run(SKAction.setTexture(SKTexture(imageNamed: "20")))
        } else if number > 0 {
            healthHudBackground?.run(SKAction.setTexture(SKTexture(imageNamed: "10")))
        } else {
            healthHudBackground?.run(SKAction.setTexture(SKTexture(imageNamed: "0")))
        }
        
        healthHudBackground?.run(fadeIn)
        healthHudBackground?.alpha = 1.0
    }
    
    /**
     Updates the level badge to a number
     
     - Parameters:
        - number: The number to update the level to
     */
    func updateLevel(_ number: Int) {
        let levelBadgeNumber = childNode(withName: "levelBadgeCount") as? SKLabelNode
        levelBadgeNumber?.fontName = NSFont.systemFont(ofSize: 18).fontName
        levelBadgeNumber?.text = String(number)
    }
    
    /**
     Updates the name of the entity under the HUD
     
     - Parameters:
        - name: The string to update the name to
     */
    func updateName(_ name: String) {
        let nameLabel = childNode(withName: "entityNameLabel") as? SKLabelNode
        nameLabel?.fontName = NSFont.boldSystemFont(ofSize: 18).fontName
        nameLabel?.text = name
    }
    
    
    /**
     Updates the health, level, and name at once
     
     - Parameters:
         - newHealth: The health number to update
         - newLevel: The level number to update
         - newName: The string to update
     */
    func update(newHealth: Int, newLevel: Int, newName: String) {
        updateHealth(newHealth)
        updateLevel(newLevel)
        updateName(newName)
    }
}
