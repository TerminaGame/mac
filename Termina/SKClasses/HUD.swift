//
//  HUD.swift
//  Termina for macOS
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
    
    var maxHealthNumber: Int?
    
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
        
        let numberDivisibility = (maxHealthNumber ?? 100) / 10
        
        if number > numberDivisibility * 9 {
            healthHudBackground?.run(SKAction.setTexture(SKTexture(imageNamed: "100")))
        } else if number > numberDivisibility * 8 {
            healthHudBackground?.run(SKAction.setTexture(SKTexture(imageNamed: "90")))
        } else if number > numberDivisibility * 7 {
            healthHudBackground?.run(SKAction.setTexture(SKTexture(imageNamed: "80")))
        } else if number > numberDivisibility * 6 {
            healthHudBackground?.run(SKAction.setTexture(SKTexture(imageNamed: "70")))
        } else if number > numberDivisibility * 5 {
            healthHudBackground?.run(SKAction.setTexture(SKTexture(imageNamed: "60")))
        } else if number > numberDivisibility * 4 {
            healthHudBackground?.run(SKAction.setTexture(SKTexture(imageNamed: "50")))
        } else if number > numberDivisibility * 3 {
            healthHudBackground?.run(SKAction.setTexture(SKTexture(imageNamed: "40")))
        } else if number > numberDivisibility * 2 {
            healthHudBackground?.run(SKAction.setTexture(SKTexture(imageNamed: "30")))
        } else if number > numberDivisibility * 1 {
            healthHudBackground?.run(SKAction.setTexture(SKTexture(imageNamed: "20")))
        } else if number > numberDivisibility * 0 {
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
    
    func setMaxHealth(_ amount: Int) {
        maxHealthNumber = amount
    }
    
    func toggleNameInvisibility(to: Bool) {
        let nameLabel = childNode(withName: "entityNameLabel")
        nameLabel?.isHidden = to
    }
    
    func toggleNumberInvisibility(to: Bool) {
        let number = childNode(withName: "healthHudNumber") as? SKLabelNode
        
        number?.isHidden = to
    }
    
    func toggleBadgeInvisibility(to: Bool) {
        let badgeNumber = childNode(withName: "levelBadgeCount")
        let badgeBackground = childNode(withName: "levelBadgeBackground")
        
        badgeBackground?.isHidden = to
        badgeNumber?.isHidden = to
    }
    
}
