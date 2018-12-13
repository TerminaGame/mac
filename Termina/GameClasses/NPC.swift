//
//  NPC.swift
//  Termina
//
//  Created by Marquis Kurt on 12/13/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

import Foundation
import SpriteKit

class NPC: Entity {
    
    var associatedHud: HUD
    
    /**
        The associated dialogue for the NPC
     */
    var dialogue = [String]()
    
    func speak() {
        for line in dialogue {
            print(line)
        }
    }
    
    init(name: String, node: SKSpriteNode, hud: HUD) {
        associatedHud = hud
        
        super.init(thisName: name, thisLevel: 0, defaultHealth: 100, thisNode: node)
        
        associatedHud.update(newHealth: health, newLevel: level, newName: name)
    }
    
}
