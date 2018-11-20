//
//  Termina.swift
//  Termina
//
//  Created by Marquis Kurt on 11/20/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

import Foundation
import SpriteKit

class Termina: Monster {
    
    private let apikey = "2be7654ed74eb3670ac46cf3bffd7a2c354159ab"
    
    func insult() {}
    
    func speakBeforeFighting() {}
    
    override func takeDamage(_ amount: Int) {
        if Int.random(in: 0...10) > 3 {
            super.takeDamage(amount)
        } else {
            if health >= maximumHealth / 2 {
                heal(Int.random(in: 5...7))
            }
        }
    }
    
    init(terminaNode: SKSpriteNode) {
        super.init(myName: "Termina", myLevel: 420, myNode: terminaNode, myHealth: 4200, pacifiable: "yes")
    }
    
}
