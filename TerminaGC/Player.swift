//
//  Player.swift
//  Termina for macOS
//
//  Created by Marquis Kurt on 11/19/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

import Foundation
import SpriteKit
import UserNotifications
import GameKit

/**
 Base class for the player
 */
class Player: Entity {
    /**
     Player's inventory as an array of items
     */
    var currentInventory = [Item]()
    
    /**
     Experience level
     */
    var patchNumber: Int
    
    /**
     Temporary level. Used by weapons to increase a player's attack
     */
    var temporaryLevel: Int
    
    /**
     Player's associated HUD
     */
    var associatedHud: HUD
    
    /**
     Take damage and update the HUD to reflect the current health
     
     - Parameters:
        - amount: The amount to take damage by
     */
    override func takeDamage(_ amount: Int) {
        super.takeDamage(amount)
        associatedHud.updateHealth(health)
        
        if health == 0 {
            associatedHud.removeFromParent()
        }
    }
    
    /**
     Heal and update the HUD to reflect current health
     
     - Parameters:
        - amount: The amount to heal by
     */
    override func heal(_ amount: Int) {
        super.heal(amount)
        associatedHud.updateHealth(health)
    }
    
    /**
     Increment the level, update the HUD, and send a notification to congratulate the player
     
     - Parameters:
        - amount: The amount to increase the level by
     */
    override func levelUp(_ amount: Int) {
        super.levelUp(amount)
        associatedHud.updateLevel(level)
        
        if TerminaUserDefaults.canSendNotifications && TerminaUserDefaults.canSendGameNotifications {
            let title = "Level Up!"
            let body = "You upgraded to version \(level)."
            GKNotificationBanner.show(withTitle: title, message: body) {  }
        }
        
        updateHealthDynamically()
        
        if TerminaUserDefaults.shouldSaveOnLevelUp {
            AppDelegate.dataModel.saveToFile(false)
        }
    }
    
    /**
     Increase the experience by an amount and level up if it goes over
     
     - Parameters:
        - amount: The amount to increase the experience by
     */
    func patchUp(_ amount: Int) {
        let temporaryPatch = patchNumber + amount
        if temporaryPatch >= 25 {
            levelUp(1)
            patchNumber = temporaryPatch - 25
        } else { patchNumber = temporaryPatch }
    }
    
    /**
        Returns player data as a dictionary
     */
    func asArray() -> Dictionary<String, String> {
        let playerDictionary = [
            "name": name,
            "level": String(level),
            "health": String(health),
            "patch": String(patchNumber)
            ] as [String : String]
        return playerDictionary
    }
    
    /**
     Updates the health dynamically.
     
     This is used to increase the maximum amount of health of the player as he/she progresses in the game.
     */
    func updateHealthDynamically() {
        maximumHealth += level / 10
    }
    
    /**
     Determines whether the given health and level of the player matches with dynamic health.
     
     - Returns: Boolean value that indicates dynamic health checking
     */
    func matchesDynamicHealth() -> Bool {
        if maximumHealth == 100 + level / 10 {
            if health > maximumHealth {
                return false
            } else {
                return true
            }
        } else {
            return false
        }
    }
    
    /**
     Initializes the Player class.
     
     - Parameters:
        - name: The name of the player
        - playerNode: The player's SKSpriteNode in an SKScene
        - playerHud: The player's HUD
     */
    init(name: String, playerNode: SKSpriteNode, playerHud: HUD) {
        //Pre super-init
        patchNumber = 0
        temporaryLevel = 0
        associatedHud = playerHud
        
        super.init(thisName: name, thisLevel: 10, defaultHealth: 100, thisNode: playerNode)
        
        //Post super-init
        associatedHud.update(newHealth: health, newLevel: level, newName: name)
    }
    
    /**
     Initializes the Player class.
     
     Use this class if you need to quickly access the Player class without hooking it up to a sprite and HUD.
     
     - Parameters:
        - name: The player's name
     */
    init(name: String) {
        patchNumber = 0
        temporaryLevel = 0
        associatedHud = HUD()
        
        super.init(thisName: name, thisLevel: 1, defaultHealth: 100)
        
        
        
    }
    
}
