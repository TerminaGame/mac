//
//  Bottle.swift
//  Termina
//
//  Created by Marquis Kurt on 11/20/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

import Foundation
import SpriteKit

class Bottle: Item {
    /**
     The player to patch up with
     */
    var player: Player
    
    /**
     Patch the player and then count it as a use
     */
    override func use() {
        player.patchUp(effect)
        super.use()
    }
    
    /**
     Initializes the Bottle class
     
     The maximum use of this item is 1.
     
     - Parameters:
         - bottleName: The name of the bottle
         - affectedPlayer: The player to receive patches
         - bottleNode: The associated SKNode
     */
    init(bottleName: String, affectedPlayer: Player, bottleNode: SKNode) {
        player = affectedPlayer
        
        super.init(itemName: bottleName, itemNode: bottleNode)
        
        maximumUse = 1
        currentUse = 1
    }
}
