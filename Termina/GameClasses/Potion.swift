//
//  Potion.swift
//  Termina
//
//  Created by Marquis Kurt on 11/20/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

import Foundation
import SpriteKit

class Potion: Item {
    /**
     The player to administer health to
     */
    var player: Player
    
    /**
     Heal the player and count it as a use
     */
    override func use() {
        if currentUse > 0 {
            super.use()
            player.heal(effect)
        } else {
            associatedNode.removeFromParent()
        }
    }
    
    /**
     Initializes the Potion class.
     
     - Parameters:
         - potionName: The name of the potion
         - affectedPlayer: The player to administer health to
         - potionNode: The potion's SKNode in an SKScene
     */
    init(potionName: String, affectedPlayer: Player, potionNode: SKNode) {
        player = affectedPlayer
        
        super.init(itemName: potionName, itemNode: potionNode)
    }
}
