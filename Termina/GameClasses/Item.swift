//
//  Item.swift
//  Termina for macOS
//
//  Created by Marquis Kurt on 11/20/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

import Foundation
import SpriteKit

/**
 Base class for items
 */
class Item {
    /**
     The name of the item
     */
    var name: String
    
    /**
     The item's power.
     */
    var effect: Int
    
    /**
     The maximum amount of uses for this item.
     */
    var maximumUse: Int
    
    /**
     The amount of uses it has received.
     */
    var currentUse: Int
    
    /**
     The associated node from an SKScene
     */
    var associatedNode: SKNode
    
    /**
     Fade the item's sprite after each use.
     */
    func pulse() {
        associatedNode.run(SKAction.fadeAlpha(by: CGFloat(1.0 / Double(maximumUse * -1)), duration: 0.5))
    }
    
    /**
     Increment the current use counter and pulse
     */
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
    
    /**
     Initializes the Item class.
     
     - Parameters:
         - itemName: The name of the item
         - itemNode: The associated SKNode from an SKScene
     */
    init(itemName: String, itemNode: SKNode) {
        name = itemName
        effect = Int.random(in: 10 ... 20)
        maximumUse = Int.random(in: 2 ... 10)
        currentUse = maximumUse
        associatedNode = itemNode
    }
    
}
