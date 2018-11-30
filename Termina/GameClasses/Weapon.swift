//
//  Weapon.swift
//  Termina
//
//  Created by Marquis Kurt on 11/20/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

import Foundation
import SpriteKit

class Weapon: Item {
    var level: Int
    var equipper: Player
    
    func equip() {
        equipper.currentInventory.append(self)
        equipper.temporaryLevel = level
        //equipper.associatedNode.texture = SKTexture(imageNamed: "PlayerWithWeapon")
        associatedNode.removeFromParent()
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
    
    func unequip() {
        if currentUse == maximumUse { equipper.temporaryLevel = 0 }
        equipper.currentInventory.removeLast()
        //equipper.associatedNode.texture = SKTexture(imageNamed: "Player")
    }
    
    init(name: String, equipLevel: Int, player: Player, node: SKNode) {
        level = equipLevel
        equipper = player
        
        super.init(itemName: name, itemNode: node)
    }
}
