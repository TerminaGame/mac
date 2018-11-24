//
//  RoomScene.swift
//  TerminaSK Shared
//
//  Created by Marquis Kurt on 11/17/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

import SpriteKit
import Foundation

class RoomScene: SKScene {
    
    var hasEntity = false
    var roomEntity: Entity?
    var gamePlayer: Player?
    var items = [Item]()
    var leaveFlag = false
    
    var roomBackground: SKSpriteNode?
    var deathOverlay: SKSpriteNode?
    
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
    
    func setUpEntity() {
        let randomSeed = Int.random(in: 0...9)
        if randomSeed > 4 {
            hasEntity = true
            
            if gamePlayer?.level ?? 1 < 8 {
                let monsterLevel = Int.random(in: 1 ... 7)
                if gamePlayer?.level ?? 1 > monsterLevel {
                    roomEntity = Monster(myName: NameGenerator().generateMonsterName(), myLevel: monsterLevel, myNode: childNode(withName: "enemyNode") as! SKSpriteNode, myHealth: 100, pacifiable: "yes", thisHud: childNode(withName: "otherHud") as! HUD)
                } else {
                    roomEntity = Monster(myName: NameGenerator().generateMonsterName(), myLevel: monsterLevel, myNode: childNode(withName: "enemyNode") as! SKSpriteNode, myHealth: 100, pacifiable: "no", thisHud: (childNode(withName: "otherHud") as! HUD))
                }
                
            } else {
                let monsterLevel = Int.random(in: ((gamePlayer?.level ?? 1) - 15)...((gamePlayer?.level ?? 1) + 15))
                if gamePlayer?.level ?? 1 > monsterLevel {
                    roomEntity = Monster(myName: NameGenerator().generateMonsterName(), myLevel: monsterLevel, myNode: childNode(withName: "enemyNode") as! SKSpriteNode, myHealth: 100, pacifiable: "yes", thisHud: childNode(withName: "otherHud") as! HUD)
                } else {
                    roomEntity = Monster(myName: NameGenerator().generateMonsterName(), myLevel: monsterLevel, myNode: childNode(withName: "enemyNode") as! SKSpriteNode, myHealth: 100, pacifiable: "no", thisHud: childNode(withName: "otherHud") as! HUD)
                }
            }
        } else {
            childNode(withName: "otherHud")?.removeFromParent()
            childNode(withName: "enemyNode")?.removeFromParent()
        }
    }
    
    func setUpBackground(_ bg: Int?) {
        roomBackground = childNode(withName: "roomBackground") as? SKSpriteNode
        if bg == nil {
            roomBackground?.texture = SKTexture(imageNamed: "bg" + String(Int.random(in: 28...29)))
        } else {
            roomBackground?.texture = SKTexture(imageNamed: "bg" + String(bg ?? 1))
        }
        
    }
    
    func setUpPlayer() {
        gamePlayer = AppDelegate.dataModel.player
        gamePlayer?.associatedNode = (childNode(withName: "playerSprite") as? SKSpriteNode)!
        gamePlayer?.associatedHud = (childNode(withName: "playerHud") as? HUD)!
        gamePlayer?.associatedHud.update(newHealth: gamePlayer?.health ?? 100, newLevel: gamePlayer?.level ?? 1, newName: gamePlayer?.name ?? "Name")
    }
    
    func setUpScene() {
        self.size = CGSize(width: 1280, height: 720)
        self.scaleMode = .aspectFit
        
        setUpBackground(nil)
        
        setUpPlayer()
        
        configureTileMap(map: childNode(withName: "baseTilemap") as! SKTileMapNode, movable: false)
        if childNode(withName: "movableTiles") != nil {
            configureTileMap(map: childNode(withName: "movableTiles") as! SKTileMapNode, movable: true)
        }
        
        
        if childNode(withName: "enemyNode") != nil { setUpEntity() }
        
        deathOverlay = childNode(withName: "deathOverlay") as? SKSpriteNode
        if gamePlayer?.health ?? 100 >= 10 {
            deathOverlay?.alpha = 0.0
        } else {
            deathOverlay?.run(SKAction.fadeAlpha(to: 0.3, duration: 1.0))
        }
        
    }
    
    override func didMove(to view: SKView) {
        self.setUpScene()
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        self.size = CGSize(width: 1280, height: 720)
        self.scaleMode = .aspectFit
        
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
        } else if (Keyboard.sharedKeyboard.justPressed(keys: Key.E)) {
            presentNewScene(29)
        } else if (Keyboard.sharedKeyboard.justPressed(keys: Key.K)) {
            gamePlayer?.health = 0
            presentDeathMessage(how: "magic")
        } else if (Keyboard.sharedKeyboard.justPressed(keys: Key.Esc)) {
            self.scaleMode = .aspectFit
            self.view?.presentScene(SKScene(fileNamed: "MainMenu")!, transition: SKTransition.fade(with: NSColor.white, duration: 0.5))
            
        }
        
        if gamePlayer?.health ?? 100 <= 10 {
            if deathOverlay?.alpha != 0.3 {
                deathOverlay?.run(SKAction.fadeAlpha(to: 0.3, duration: 1.0))
            }
        }
    }
    
    func presentNewScene(_ override: Int?) {
        self.size = CGSize(width: 1280, height: 720)
        self.scaleMode = .aspectFit
        if override != nil {
            self.view?.presentScene(SKScene(fileNamed: String(override ?? 0))!, transition: SKTransition.fade(withDuration: 1.5))
        } else {
            self.view?.presentScene(SKScene(fileNamed: String(Int.random(in: 0...28)))!, transition: SKTransition.fade(withDuration: 1.5))
        }
        self.size = CGSize(width: 1280, height: 720)
        self.scaleMode = .aspectFit
    }
    
    func presentDeathMessage(how: String) {
        let alert = NSAlert()
        alert.alertStyle = NSAlert.Style.critical
        alert.messageText = "You died!"
        
        switch (how) {
        case "magic":
            alert.informativeText = "Unfortunately, you died from a magic spell."
            break
        case "error":
            alert.informativeText = "Unfortunately, \(roomEntity?.name ?? "the error") crashed you before you could catch it."
            break
        default:
            alert.informativeText = "Unfortunately, you died of mysterious causes..."
            break
        }
        
        alert.addButton(withTitle: "Restart")
        alert.addButton(withTitle: "Quit")
        alert.beginSheetModal(for: (self.view?.window!)!) {
            (returnCode: NSApplication.ModalResponse) -> Void in
            if returnCode.rawValue == 1001 {
                exit(0)
            } else {
                let _ = AppDelegate.dataModel.loadFromFile()
                self.presentNewScene(29)
            }
        }
    }
    
    func attackHere() {
        if roomEntity != nil {
            if roomEntity is Monster {
                if gamePlayer?.associatedNode.position.x ?? 0 < 50 + (roomEntity?.associatedNode.position.x ?? 0) {
                    let damageFromPlayer = (gamePlayer?.level ?? 1) + (gamePlayer?.temporaryLevel ?? Int.random(in: 1 ... 3))
                    let error = roomEntity as? Monster
                    //print(damageFromPlayer)
                    error?.takeDamage(damageFromPlayer)
                    
                    if error?.health == 0 {
                        roomEntity?.associatedNode.removeFromParent()
                        roomEntity = nil
                        gamePlayer?.patchUp(5)
                    } else {
                        gamePlayer?.takeDamage(error?.attack ?? 6)
                        
                        if gamePlayer?.health == 0 {
                            gamePlayer?.associatedNode.removeFromParent()
                            gamePlayer = nil
                            presentDeathMessage(how: "error")
                        }
                    }
                }
                
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
