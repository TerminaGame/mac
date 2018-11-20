//
//  Entity.swift
//  Termina
//
//  Created by Marquis Kurt on 11/19/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

import Foundation
import SpriteKit

class Entity {
    var name: String
    var health: Int
    var maximumHealth: Int
    var level: Int
    var associatedNode: SKSpriteNode
    
    // SKActions
    let SKJumpAction = SKAction.moveBy(x: 0, y: 150, duration: 0.25)
    let SKMoveLeftAction = SKAction.moveBy(x: -10, y: 0, duration: 0.25)
    let SKMoveRightAction = SKAction.moveBy(x: 10, y: 0, duration: 0.25)
    let SKDamageLeftAction = SKAction.moveBy(x: -5, y: 50, duration: 0.25)
    let SKDamageRightAction = SKAction.moveBy(x: 5, y: 50, duration: 0.25)
    
    func takeDamage(_ amount: Int) {
        let temporaryHealth = health - amount
        if temporaryHealth < 0 {
            health = 0
        } else {
            health = temporaryHealth
        }
        if associatedNode.position.x < 0 {
            associatedNode.run(SKDamageLeftAction)
        } else {
            associatedNode.run(SKDamageRightAction)
        }
    }
    
    func heal(_ amount: Int) {
        let temporaryHealth = health + amount
        if temporaryHealth > maximumHealth {
            health = maximumHealth
        } else {
            health = temporaryHealth
        }
    }
    
    func levelUp(_ amount: Int) {
        level += amount
    }
    
    func parseDialogue(monologue: [String]) {}
    
    func jump() {
        associatedNode.run(SKJumpAction)
    }
    
    func move(_ direction: String) {
        if direction == "left" {
            associatedNode.run(SKMoveLeftAction)
        } else if direction == "right" {
            associatedNode.run(SKMoveRightAction)
        }
    }
    
    init(thisName: String, thisLevel: Int, defaultHealth: Int, thisNode: SKSpriteNode) {
        name = thisName
        level = thisLevel
        health = defaultHealth
        maximumHealth = defaultHealth
        associatedNode = thisNode
    }
}
