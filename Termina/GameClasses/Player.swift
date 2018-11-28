//
//  Player.swift
//  Termina
//
//  Created by Marquis Kurt on 11/19/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

import Foundation
import SpriteKit
import UserNotifications

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
    
    override func heal(_ amount: Int) {
        super.heal(amount)
        associatedHud.updateHealth(health)
    }
    
    override func levelUp(_ amount: Int) {
        super.levelUp(amount)
        associatedHud.updateLevel(level)
        let content = UNMutableNotificationContent()
        content.title = "Congratulations!"
        content.body = "You upgraded to version \(level)!"
        let uuid = UUID().uuidString
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.01, repeats: false)
        let newNotificationRequest = UNNotificationRequest(identifier: uuid, content: content, trigger: trigger)
        let center = UNUserNotificationCenter.current()
        center.add(newNotificationRequest, withCompletionHandler: nil)
    }
    
    func patchUp(_ amount: Int) {
        let temporaryPatch = patchNumber + amount
        if temporaryPatch >= 25 {
            levelUp(1)
            patchNumber = temporaryPatch - 25
        } else { patchNumber = temporaryPatch }
    }
    
    func asArray() -> Dictionary<String, String> {
        let playerDictionary = [
            "name": name,
            "level": String(level),
            "health": String(health),
            "patch": String(patchNumber)
            ] as [String : String]
        return playerDictionary
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
    
    init(name: String) {
        patchNumber = 0
        temporaryLevel = 0
        associatedHud = HUD()
        
        super.init(thisName: name, thisLevel: 1, defaultHealth: 100)
        
        
        
    }
    
}
