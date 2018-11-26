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
    
    func use() {
        if currentUse > 0 {
            if currentUse - 1 <= 0 {
                currentUse = 0
            } else {
                currentUse -= 1
            }
        } else {
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
