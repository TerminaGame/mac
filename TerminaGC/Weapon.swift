//
//  Weapon.swift
//  Termina for macOS
//
//  Created by Marquis Kurt on 11/20/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

import Foundation
import SpriteKit
import UserNotifications
import GameKit

class Weapon: Item {
    /**
     Level of attack
     */
    var level: Int
    
    /**
     The player that is holding the weapon
     */
    var equipper: Player
    
    /**
     Adds the weapon to the player's inventory and removes the node from its parent scene.
     */
    func equip() {
        equipper.currentInventory.append(self)
        equipper.temporaryLevel = level
        equipper.associatedNode.texture = SKTexture(imageNamed: "PlayerWithWeapon")
        associatedNode.removeFromParent()
        
        if TerminaUserDefaults.canSendNotifications && TerminaUserDefaults.canSendGameNotifications {
            let title = "You just equipped \(name) v.\(level)!"
            let body = "This item has a total of \(maximumUse) uses."
            GKNotificationBanner.show(withTitle: title, message: body) {  }
        }
    }
    
    override func use() {
        if currentUse <= 0 {
            unequip()
        } else {
            super.use()
            if equipper.temporaryLevel - 1 < 0 {
                equipper.temporaryLevel = 0
                unequip()
            } else {
                equipper.temporaryLevel -= 1
            }
        }
    }
    
    /**
     Removes the item from the player's inventory
     */
    func unequip() {
        if currentUse == maximumUse { equipper.temporaryLevel = 0 }
        equipper.currentInventory.removeLast()
        equipper.associatedNode.texture = SKTexture(imageNamed: "Player")
    }
    
    /**
     Initializes the Weapon object
     
     - Parameters:
         - name: The name of the weapon
         - equipLevel: The level of the weapon
         - player: The associated player that will equip the weapon
         - node: The associated node from the SKScene
     */
    init(name: String, equipLevel: Int, player: Player, node: SKNode) {
        level = equipLevel
        equipper = player
        
        super.init(itemName: name, itemNode: node)
    }
}
