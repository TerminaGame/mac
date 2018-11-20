//
//  Monster.swift
//  Termina
//
//  Created by Marquis Kurt on 11/20/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

import Foundation
import SpriteKit

class Monster: Entity {
    
    var attack: Int
    var canBePacified: Bool
    
    override func takeDamage(_ amount: Int) {
        if !(Int.random(in: 0...10) < 4) {
            super.takeDamage(amount)
        }
    }
    
    func pacify() {}
    
    init(myName: String, myLevel: Int, myNode: SKSpriteNode, myHealth: Int, pacifiable: String) {
        attack = myLevel + 5
        
        canBePacified = false
        if pacifiable == "yes" {
            canBePacified = true
        } else if pacifiable == "random" {
            if (Int.random(in: 0...5) > 4) {
                canBePacified = true
            }
        } else {
            canBePacified = false
        }
        
        super.init(thisName: myName, thisLevel: myLevel, defaultHealth: myHealth, thisNode: myNode)
        
    }
    
}
