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
    var player: Player
    
    override func use() {
        if currentUse > 0 {
            super.use()
            player.heal(effect)
        } else { associatedNode.removeFromParent() }
    }
    
    init(potionName: String, affectedPlayer: Player, potionNode: SKNode) {
        player = affectedPlayer
        
        super.init(itemName: potionName, itemNode: potionNode)
    }
}
