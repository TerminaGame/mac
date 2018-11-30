//
//  Item.swift
//  Termina
//
//  Created by Marquis Kurt on 11/20/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

import Foundation
import SpriteKit

class Item {
    var name: String
    var effect: Int
    var maximumUse: Int
    var currentUse: Int
    var associatedNode: SKNode
    
    func pulse() {
        associatedNode.run(SKAction.fadeAlpha(by: CGFloat(1.0 / Double(maximumUse * -1)), duration: 0.5))
        print(associatedNode.alpha)
    }
    
    func use() {
        if currentUse > 0 {
            if currentUse - 1 <= 0 {
                currentUse = 0
                associatedNode.removeFromParent()
            } else {
                currentUse -= 1
                pulse()
            }
        } else {
            NSSound.beep()
            associatedNode.removeFromParent()
        }
    }
    
    init(itemName: String, itemNode: SKNode) {
        name = itemName
        effect = Int.random(in: 10 ... 20)
        maximumUse = Int.random(in: 2 ... 10)
        currentUse = maximumUse
        associatedNode = itemNode
    }
    
}
