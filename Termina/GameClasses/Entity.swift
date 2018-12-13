//
//  Entity.swift
//  Termina
//
//  Created by Marquis Kurt on 11/19/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

import Foundation
import SpriteKit

/**
 Base class for living beings
 */
class Entity {
    /**
     The name of the entity
     */
    var name: String
    
    /**
     Current health of the entity
     */
    var health: Int
    
    /**
     Maximum or ideal health of the entity
     */
    var maximumHealth: Int
    
    /**
     Entity's level
     */
    var level: Int
    
    /**
     Entity's associated SKSpriteNode from an SKScene
     */
    var associatedNode: SKSpriteNode
    
    // SKActions
    let SKJumpAction = SKAction.moveBy(x: 0, y: 150, duration: 0.25)
    let SKMoveLeftAction = SKAction.moveBy(x: -10, y: 0, duration: 0.25)
    let SKMoveRightAction = SKAction.moveBy(x: 10, y: 0, duration: 0.25)
    let SKDamageLeftAction = SKAction.moveBy(x: -5, y: 50, duration: 0.25)
    let SKDamageRightAction = SKAction.moveBy(x: 5, y: 50, duration: 0.25)
    
    /**
     Takes damage by an amount and moves the sprite
     
     - Parameters:
        - amount: The amount of damage to give
     */
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
    
    /**
     Heals by an amount or resets the health to its maximum if it goes over
     
     - Parameters:
        - amount: Amount of health to restore
     */
    func heal(_ amount: Int) {
        let temporaryHealth = health + amount
        if temporaryHealth > maximumHealth {
            health = maximumHealth
        } else {
            health = temporaryHealth
        }
    }
    
    /**
     Increases level count
     
     - Parameters:
        - amount: The amount to increase the level by
     */
    func levelUp(_ amount: Int) {
        level += amount
    }
    
    func parseDialogue(monologue: [String]) {}
    
    func saySomething(what: String) {}
    
    /**
     Moves the sprite up and then down
     */
    func jump() {
        associatedNode.run(SKJumpAction)
    }
    
    /**
     Moves the sprite in a given direction.
     
     - Parameters:
        - direction: The direction for the sprite to move in. Either left or right.
     */
    func move(_ direction: String) {
        if direction == "left" {
            associatedNode.run(SKMoveLeftAction)
        } else if direction == "right" {
            associatedNode.run(SKMoveRightAction)
        }
    }
    
    /**
     Moves the sprite to a direction by a given coordinate.
     
     - Parameters:
        - x: How far from their origin to move on the X axis
        - y: How far from their origin to move on the Y axis
     */
    func move(x: Int, y: Int) {
        associatedNode.run(SKAction.moveBy(x: CGFloat(x), y: CGFloat(y), duration: 0.25))
    }
    
    /**
     Initializes the Entity class
     
     - Parameters:
         - thisName: The name of the entity
         - thisLevel: The entity's level
         - defaultHealth: The default and maximum health of the entity
         - thisNode: The associated SKSpriteNode from an SKScene
     */
    init(thisName: String, thisLevel: Int, defaultHealth: Int, thisNode: SKSpriteNode) {
        name = thisName
        level = thisLevel
        health = defaultHealth
        maximumHealth = defaultHealth
        associatedNode = thisNode
    }
    
    /**
     Initializes the Entity class. Automatically sets the node to a blank SKSpriteNode.
     
     Use this if you want to interact with an entity class but can't attach it to any nodes.
     
     - Parameters:
         - thisName: The name of the entity
         - thisLevel: The entity's level
         - defaultHealth: The default and maximum health of the entity
     */
    init(thisName: String, thisLevel: Int, defaultHealth: Int) {
        name = thisName
        level = thisLevel
        health = defaultHealth
        maximumHealth = defaultHealth
        
        associatedNode = SKSpriteNode()
    }
}
