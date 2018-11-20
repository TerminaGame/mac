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
    
    // SKNodes
    var roomBackground : SKSpriteNode?
    var healthHUD : SKSpriteNode?
    var healthHUDNumber: SKLabelNode?
    var levelBadgeNumber: SKLabelNode?
    var playerNameLabel: SKLabelNode?
    var player: SKSpriteNode?
    var gamePlayer: Player?
    
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
}

extension GameScene {
    
    override func mouseDown(with event: NSEvent) {
        
    }

    override func mouseDragged(with event: NSEvent) {
        
    }
    
    override func mouseUp(with event: NSEvent) {
        gamePlayer?.levelUp(1)
        gamePlayer?.takeDamage(10)
    }
    
    override func didFinishUpdate() {
        Keyboard.sharedKeyboard.update()
    }
    
    override func keyDown(with event: NSEvent) {
        Keyboard.sharedKeyboard.handleKey(event: event, isDown: true)
    }
    
    override func keyUp(with event: NSEvent) {
        Keyboard.sharedKeyboard.handleKey(event: event, isDown: false)
    }
    
}
