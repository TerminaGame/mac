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
    
    // Important vars
    var currentHealth: Int = 0
    var currentLevel: Int = 1
    var playerName: String = "Henry"
    
    
    func updateHealthStatus(number: Int) {
        
        if number <= 0 {
            currentHealth = 0
        } else if number >= 100 {
            currentHealth = 100
        }
        
        healthHUDNumber?.text = String(currentHealth)
        let fadeOut = SKAction.fadeOut(withDuration: 1)
        let fadeIn = SKAction.fadeIn(withDuration: 1)
        healthHUD?.run(fadeOut)
        if number > 90 {
            healthHUD?.run(SKAction.setTexture(SKTexture(imageNamed: "100")))
        } else if number > 80 {
            healthHUD?.run(SKAction.setTexture(SKTexture(imageNamed: "90")))
        } else if number > 70 {
            healthHUD?.run(SKAction.setTexture(SKTexture(imageNamed: "80")))
        } else if number > 60 {
            healthHUD?.run(SKAction.setTexture(SKTexture(imageNamed: "70")))
        } else if number > 50 {
            healthHUD?.run(SKAction.setTexture(SKTexture(imageNamed: "60")))
        } else if number > 40 {
            healthHUD?.run(SKAction.setTexture(SKTexture(imageNamed: "50")))
        } else if number > 30 {
            healthHUD?.run(SKAction.setTexture(SKTexture(imageNamed: "40")))
        } else if number > 20 {
            healthHUD?.run(SKAction.setTexture(SKTexture(imageNamed: "30")))
        } else if number > 10 {
            healthHUD?.run(SKAction.setTexture(SKTexture(imageNamed: "20")))
        } else if number > 0 {
            healthHUD?.run(SKAction.setTexture(SKTexture(imageNamed: "10")))
        } else {
            healthHUD?.run(SKAction.setTexture(SKTexture(imageNamed: "0")))
        }
        healthHUD?.run(fadeIn)
        
    }
    
    func updateLevelBadge(number: Int) {
        currentLevel = number
        levelBadgeNumber?.text = String(currentLevel)
    }
    
    func updatePlayerHUD(health: Int, level: Int) {
        updateHealthStatus(number: health)
        updateLevelBadge(number: level)
    }
    
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
        
        healthHUD = childNode(withName: "healthHudDisplay") as? SKSpriteNode
        healthHUDNumber = childNode(withName: "healthHudNumber") as? SKLabelNode
        healthHUDNumber?.fontName = NSFont.boldSystemFont(ofSize: 48).fontName
        
        currentHealth = 100
        updateHealthStatus(number: currentHealth)
        
        levelBadgeNumber = childNode(withName: "levelBadgeCount") as? SKLabelNode
        levelBadgeNumber?.fontName = NSFont.systemFont(ofSize: 18).fontName
        
        playerNameLabel = childNode(withName: "playerNameLabel") as? SKLabelNode
        playerNameLabel?.fontName = NSFont.boldSystemFont(ofSize: 18).fontName
        playerNameLabel?.text = playerName
        
        player = childNode(withName: "playerSprite") as? SKSpriteNode
        
        configureTileMap(map: childNode(withName: "baseTilemap") as! SKTileMapNode, movable: false)
        configureTileMap(map: childNode(withName: "movableTiles") as! SKTileMapNode, movable: true)
    }
    
    override func didMove(to view: SKView) {
        self.setUpScene()
    }
    
    override func update(_ currentTime: TimeInterval) {
        updateHealthStatus(number: currentHealth)
        updateLevelBadge(number: currentLevel)
        
        super.update(currentTime)
        
        if (Keyboard.sharedKeyboard.justPressed(keys: Key.space)) {
            player?.run(SKAction.moveBy(x: 0, y: 150, duration: 0.25))
        } else if (Keyboard.sharedKeyboard.justPressed(keys: Key.D)) {
            player?.run(SKAction.moveBy(x: 10, y: 0, duration: 0.25))
        } else if (Keyboard.sharedKeyboard.justPressed(keys: Key.A)) {
            player?.run(SKAction.moveBy(x: -10, y: 0, duration: 0.25))
        } else if (Keyboard.sharedKeyboard.pressed(keys: Key.D, Key.W)) {
            player?.run(SKAction.moveBy(x: 10, y: 0, duration: 0.25))
        } else if (Keyboard.sharedKeyboard.pressed(keys: Key.W, Key.A)) {
            player?.run(SKAction.moveBy(x: -10, y: 0, duration: 0.25))
        }
    }
}

extension GameScene {
    
    override func mouseDown(with event: NSEvent) {
        
    }

    override func mouseDragged(with event: NSEvent) {
        
    }
    
    override func mouseUp(with event: NSEvent) {
        currentHealth = currentHealth - 10
        currentLevel += 1
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

