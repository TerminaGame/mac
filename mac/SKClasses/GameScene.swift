//
//  GameScene.swift
//  TerminaSK Shared
//
//  Created by Marquis Kurt on 11/17/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

import SpriteKit
import Foundation

class GameScene: SKScene {
    
    var hasEntity = false
    var roomEntity: Entity?
    var gamePlayer: Player?
    //var items: [Item]()
    var leaveFlag = false
    
    var roomBackground: SKSpriteNode?
    
    /**
     Configure the tilemap and then destroy the parent tilemap.
     
     - Parameters:
        - map: The tilemap to configure
        - movable: Whether the tiles should be movable
     */
    func configureTileMap(map: SKTileMapNode, movable: Bool) {
        let tileMapSize = map.tileSize
        
        let halfWidth = tileMapSize.width / 2.0
        let halfHeight = tileMapSize.height / 2.0
        
        let tileMapPosition = map.position
        
        for column in 0 ..< map.numberOfColumns {
            for row in 0 ..< map.numberOfRows {
                
                if let tileDefinition = map.tileDefinition(atColumn: column, row: row) {
                    let tileArray = tileDefinition.textures
                    let tileTexture = tileArray[0]
                    
                    let x = CGFloat(column) * tileMapSize.width - halfWidth + (tileMapSize.width / 2)
                    let y = CGFloat(row) * tileMapSize.height - halfHeight + (tileMapSize.height / 2)
                    
                    let tileNode = SKSpriteNode(texture: tileTexture)
                    tileNode.position = CGPoint(x: x, y: y)
                    tileNode.physicsBody = SKPhysicsBody(texture: tileTexture, size: CGSize(width: (tileTexture.size().width), height: (tileTexture.size().height)))
                    tileNode.physicsBody?.restitution = 0
                    
                    // If the tiles are supposed to stay in place
                    if !movable {
                        tileNode.physicsBody?.isDynamic = false
                        tileNode.physicsBody?.affectedByGravity = false
                        tileNode.physicsBody?.linearDamping = 1000.0
                        tileNode.physicsBody?.allowsRotation = false
                        tileNode.physicsBody?.friction = 0.7
                    }
                    
                    // If the tiles are to be moved around
                    else {
                        tileNode.physicsBody?.affectedByGravity = true
                        tileNode.physicsBody?.linearDamping = 0.1
                        tileNode.physicsBody?.allowsRotation = true
                        tileNode.physicsBody?.friction = 1.0
                        tileNode.physicsBody?.mass = 100
                    }
                    self.addChild(tileNode)
                    
                    tileNode.position = CGPoint(x: tileNode.position.x + tileMapPosition.x, y: tileNode.position.y + tileMapPosition.y)
                }
                
            }
        }
        
        map.removeFromParent()
    }
    
    func setUpScene() {
        roomBackground = childNode(withName: "roomBackground") as? SKSpriteNode
        roomBackground?.texture = SKTexture(imageNamed: "bg29")
        
        gamePlayer = Player(name: "Frisk", playerNode: (childNode(withName: "playerSprite") as? SKSpriteNode)!, playerHud: (childNode(withName: "playerHud") as? HUD)!)
        
        
        configureTileMap(map: childNode(withName: "baseTilemap") as! SKTileMapNode, movable: false)
        configureTileMap(map: childNode(withName: "movableTiles") as! SKTileMapNode, movable: true)
        
        let randomSeed = Int.random(in: 0...9)
        if randomSeed > 4 {
            hasEntity = true
            
            if gamePlayer?.level ?? 1 < 8 {
                let monsterLevel = Int.random(in: 1 ... 7)
                if gamePlayer?.level ?? 1 > monsterLevel {
                    roomEntity = Monster(myName: "Error", myLevel: monsterLevel, myNode: childNode(withName: "enemyNode") as! SKSpriteNode, myHealth: 100, pacifiable: "yes", thisHud: childNode(withName: "otherHud") as! HUD)
                } else {
                    roomEntity = Monster(myName: "Error", myLevel: monsterLevel, myNode: childNode(withName: "enemyNode") as! SKSpriteNode, myHealth: 100, pacifiable: "no", thisHud: (childNode(withName: "otherHud") as! HUD))
                }
                
            } else {
                let monsterLevel = Int.random(in: ((gamePlayer?.level ?? 1) - 15)...((gamePlayer?.level ?? 1) + 15))
                if gamePlayer?.level ?? 1 > monsterLevel {
                    roomEntity = Monster(myName: "Error", myLevel: monsterLevel, myNode: childNode(withName: "enemyNode") as! SKSpriteNode, myHealth: 100, pacifiable: "yes", thisHud: childNode(withName: "otherHud") as! HUD)
                } else {
                    roomEntity = Monster(myName: "Error", myLevel: monsterLevel, myNode: childNode(withName: "enemyNode") as! SKSpriteNode, myHealth: 100, pacifiable: "no", thisHud: childNode(withName: "otherHud") as! HUD)
                }
            }
            
            roomEntity?.associatedNode.run(SKAction.moveTo(x: (gamePlayer?.associatedNode.position.x ?? 0) + 200, duration: 3))
            
        } else {
            childNode(withName: "otherHud")?.removeFromParent()
            childNode(withName: "enemyNode")?.removeFromParent()
        }
    }
    
    override func didMove(to view: SKView) {
        self.setUpScene()
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        
        if (Keyboard.sharedKeyboard.justPressed(keys: Key.space)) {
            gamePlayer?.jump()
        } else if (Keyboard.sharedKeyboard.justPressed(keys: Key.D)) {
            gamePlayer?.move("right")
        } else if (Keyboard.sharedKeyboard.justPressed(keys: Key.A)) {
            gamePlayer?.move("left")
        } else if (Keyboard.sharedKeyboard.pressed(keys: Key.D, Key.W)) {
            gamePlayer?.move("right")
        } else if (Keyboard.sharedKeyboard.pressed(keys: Key.W, Key.A)) {
            gamePlayer?.move("left")
        }
    }
    
    func attackHere() {
        if roomEntity != nil {
            if roomEntity is Monster {
//                if gamePlayer?.associatedNode.position.x ?? 0 >= 50 + (roomEntity?.associatedNode.position.x ?? 0) {
                    let damageFromPlayer = (gamePlayer?.level ?? 1) + (gamePlayer?.temporaryLevel ?? Int.random(in: 1 ... 3))
                    let error = roomEntity as? Monster
                    print(damageFromPlayer)
                    
                    if error?.health == 0 {
                        roomEntity?.associatedNode.removeFromParent()
                        roomEntity = nil
                        gamePlayer?.patchUp(5)
                    } else {
                        gamePlayer?.takeDamage(error?.attack ?? 6)
                        
                        if gamePlayer?.health == 0 {
                            gamePlayer?.associatedNode.removeFromParent()
                            gamePlayer = nil
                            // Exit code
                        }
                    }
//                }
                
            } else {
                roomEntity?.takeDamage(100)
                roomEntity?.associatedNode.removeFromParent()
                gamePlayer?.takeDamage(50)
            }
        } else {
            // play sound
        }
    }
}
