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
    var player: Player
    
    override func use() {
        player.patchUp(effect)
        super.use()
    }
    
    init(bottleName: String, affectedPlayer: Player, bottleNode: SKNode) {
        player = affectedPlayer
        
        super.init(itemName: bottleName, itemNode: bottleNode)
        
        maximumUse = 1
        currentUse = 1
    }
}
