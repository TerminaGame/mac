//
//  RoomScene.swift
//  mac
//
//  Created by Marquis Kurt on 11/17/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

import SpriteKit
import Foundation
import UserNotifications

class RoomScene: SKScene {
    
    var hasEntity = false
    
    /**
     The room's entity, either a monster or NPC.
     */
    var roomEntity: Entity?
    
    /**
     The room's player
     */
    var gamePlayer: Player?
    
    /**
     The room's inventory
     */
    var items = [Item]()
    var leaveFlag = false
    
    var roomBackground: SKSpriteNode?
    var weaponNode: SKSpriteNode?
    var bottleNode: SKSpriteNode?
    var deathOverlay: SKSpriteNode?
    var exitRoom: SKSpriteNode?
    
    /**
     Create a tile node for every item in a tilemap and then remove the tilemap.
     
     - Parameters:
        - map: The tilemap to create tile nodes for.
        - movable: Whether the tiles nodes will be affected by gravity and can be moved by entities or other nodes
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
    
    /**
     Sets up the entities in a given room.
     */
    func setUpEntity() {
        let randomSeed = Int.random(in: 0...9)
        let enemyNode = childNode(withName: "enemyNode") as! SKSpriteNode
        let enemyHud = childNode(withName: "otherHud") as! HUD
        let enemyName = NameGenerator().generateMonsterName()
        
        
        if randomSeed > 4 {
            hasEntity = true
            
            if gamePlayer?.level ?? 1 < 15 {
                let monsterLevel = Int.random(in: 1 ... 14)
                if gamePlayer?.level ?? 1 > monsterLevel {
                    roomEntity = Monster(
                        myName: enemyName,
                        myLevel: monsterLevel,
                        myNode: enemyNode,
                        myHealth: 100,
                        pacifiable: "yes",
                        thisHud: enemyHud
                    )
                } else {
                    roomEntity = Monster(
                        myName: enemyName,
                        myLevel: monsterLevel,
                        myNode: enemyNode,
                        myHealth: 100,
                        pacifiable: "no",
                        thisHud: enemyHud
                    )
                }
                
            } else {
                let monsterLevel = Int.random(in: ((gamePlayer?.level ?? 1) - 15)...((gamePlayer?.level ?? 1) + 15))
                if gamePlayer?.level ?? 1 > monsterLevel {
                    roomEntity = Monster(
                        myName: enemyName,
                        myLevel: monsterLevel,
                        myNode: enemyNode,
                        myHealth: 100,
                        pacifiable: "yes",
                        thisHud: enemyHud
                    )
                } else {
                    roomEntity = Monster(
                        myName: enemyName,
                        myLevel: monsterLevel,
                        myNode: enemyNode,
                        myHealth: 100,
                        pacifiable: "no",
                        thisHud: enemyHud
                    )
                }
            }
            
            // Change the node's size to the size of the texture
            roomEntity?.associatedNode.size = CGSize(width: 64, height: 64)
            
            // Change the node's texture
            roomEntity?.associatedNode.texture = SKTexture(imageNamed: "ErrorNode")
            
            // Create a new physics body and hitbox, respectively.
            roomEntity?.associatedNode.physicsBody? = SKPhysicsBody(rectangleOf: (roomEntity?.associatedNode.size)!)
            
            // Change the physics body so that it follows the same rules as the player.
            let entityPhysics = roomEntity?.associatedNode.physicsBody
            
            entityPhysics?.isDynamic = true
            entityPhysics?.restitution = 0
            entityPhysics?.mass = 70
            entityPhysics?.affectedByGravity = true
            entityPhysics?.allowsRotation = false
            entityPhysics?.friction = 0.7
            
        } else {
            enemyHud.removeFromParent()
            enemyNode.removeFromParent()
        }
    }
    
    /**
     Randomly selects a background from a list.
     
     - Parameters:
        - bg: The number of the background to update to. If filled, will not randomly select a background.
     */
    func setUpBackground(_ bg: Int?) {
        roomBackground = childNode(withName: "roomBackground") as? SKSpriteNode
        if bg == nil && self.name != "Tutorial" {
            
            // For special backgrounds, they need to be paired with the right scene.
            if self.name == "20" {
                roomBackground?.texture = SKTexture(imageNamed: "bg25")
            } else {
                let randomLower = Int.random(in: 1...24)
                let randomUpper = Int.random(in: 26...28)
                let chosenOne = Bool.random()
                
                if chosenOne {
                    roomBackground?.texture = SKTexture(imageNamed: "bg" + String(randomLower))
                } else {
                    roomBackground?.texture = SKTexture(imageNamed: "bg" + String(randomUpper))
                }
                
            }
        } else {
            roomBackground?.texture = SKTexture(imageNamed: "bg" + String(bg ?? 1))
        }
        
    }
    
    /**
     Sets up the player and hooks it to the AppDelegate's player
     */
    func setUpPlayer() {
        gamePlayer = AppDelegate.dataModel.player
        gamePlayer?.associatedNode = (childNode(withName: "playerSprite") as? SKSpriteNode)!
        gamePlayer?.associatedHud = (childNode(withName: "playerHud") as? HUD)!
        gamePlayer?.associatedHud.update(newHealth: gamePlayer?.health ?? 100, newLevel: gamePlayer?.level ?? 1, newName: gamePlayer?.name ?? "Name")
        
        if gamePlayer?.currentInventory.last != nil {
            gamePlayer?.associatedNode.texture = SKTexture(imageNamed: "PlayerWithWeapon")
        }
    }
    
    /**
     Sets up the weapon in a given room
     */
    func setUpWeapon() {
        if childNode(withName: "weaponItemNode") != nil {
            weaponNode = childNode(withName: "weaponItemNode") as? SKSpriteNode
            weaponNode?.texture = SKTexture(imageNamed: "Weapon")
            
            let chance = Int.random(in: 0...10)
            if (chance >= 3 && chance <= 6) {
                items.append(Weapon(name: NameGenerator().generateWeaponName(), equipLevel: Int.random(in: 1...(gamePlayer?.level ?? 1) + 5), player: gamePlayer!, node: weaponNode!))
            } else {
                weaponNode?.removeFromParent()
            }
        }
    }
    
    /**
     Sets up the potions or bottles in a given room.
     */
    func setUpBottle() {
        if childNode(withName: "bottleItemNode") != nil {
            bottleNode = childNode(withName: "bottleItemNode") as? SKSpriteNode
            
            let chance = Int.random(in: 0 ... 10)
            if chance >= 4 {
                let selectRandomHelper = Int.random(in: 0 ... 3)
                if selectRandomHelper <= 2 {
                    bottleNode?.texture = SKTexture(imageNamed: "Potion")
                    items.append(Potion(potionName: "Health Hotfix", affectedPlayer: gamePlayer!, potionNode: bottleNode!))
                } else {
                    bottleNode?.texture = SKTexture(imageNamed: "Bottle")
                    items.append(Bottle(bottleName: "Patcher", affectedPlayer: gamePlayer!, bottleNode: bottleNode!))
                }
            } else {
                bottleNode?.removeFromParent()
            }
        }
    }
    
    /**
    Sets up the room's scene and all of its components
     */
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
        
        setUpBottle()
        setUpWeapon()
        
        exitRoom = childNode(withName: "exitRoomNode") as? SKSpriteNode
        
    }
    
    override func didMove(to view: SKView) {
        self.setUpScene()
    }
    
    /**
     Attempt to use an item in the room.
     
     If the Player object is near the item, it can be used.
     */
    func useItemHere() {
        if items.first != nil {
            if isNear(node: (items.first?.associatedNode)!, maximumDistance: 75) {
                if items.first is Potion {
                    if items.first?.currentUse ?? 1 > 0 {
                        (items.first as? Potion)?.use()
                    }
                } else if items.first is Bottle {
                    if items.first?.currentUse ?? 1 > 0 {
                        (items.first as? Bottle)?.use()
                    }
                } else {
                    NSSound.beep()
                }
            } else {
                NSSound.beep()
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Ensure that the scene is always the same size
        super.update(currentTime)
        self.size = CGSize(width: 1280, height: 720)
        self.scaleMode = .aspectFit
        
        // Track the player's key presses
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
            decideItemAndAct()
        }
        else if (Keyboard.sharedKeyboard.justPressed(keys: Key.Esc)) {
            self.scaleMode = .aspectFit
            self.view?.presentScene(SKScene(fileNamed: "MainMenu")!, transition: SKTransition.fade(with: NSColor.white, duration: 0.5))
        } else if (Keyboard.sharedKeyboard.justPressed(keys: Key.Return)) {
            if self.isNear(node: exitRoom!, maximumDistance: 75) && roomEntity == nil {
                if (gamePlayer?.level ?? 1) >= 420 {
                    if self.name == "29" {
                        self.presentNewScene(nil)
                    } else {
                        self.presentNewScene(29)
                    }
                } else {
                    self.presentNewScene(nil)
                }
            } else {
                NSSound.beep()
            }
        }
        
        // Update the overlay for damage
        if gamePlayer?.health ?? 100 <= 10 {
            deathOverlay?.run(SKAction.fadeAlpha(to: 0.3, duration: 1.0))

        } else if gamePlayer?.health ?? 100 > 10 {
            deathOverlay?.run(SKAction.fadeAlpha(to: 0.0, duration: 1.0))
        }
        
        // Track the player's position and have the enemy move closer to the player
        if roomEntity != nil {
            if self.isNear(node: (roomEntity?.associatedNode)!, maximumDistance: 100) && roomEntity is Monster {
                roomEntity?.associatedNode.run(SKAction.move(to: (gamePlayer?.associatedNode.position ?? CGPoint.zero), duration: 0.5))
            }
        }
        
    }
    
    /**
     Determine the position of the player and an item and use it
     
     When using this fuction, it will attempt to use the node's name to run the corresponding action, reducing the need for another key. To do this, it cycles through all of the nodes in a scene, checks if they are near the player, and the node's name to get a match. The maximum distance is determined by the node's size and an extra eight points for padding.
     */
    func decideItemAndAct() {
        for node in self.children {
            if isNear(node: node, maximumDistance: 72) {
                if node.name == "weaponItemNode" { equipItemHere() }
                else if node.name == "bottleItemNode" { useItemHere() }
            }
        }
    }
    
    /**
     Attempts to equip an item from the room to the player.
     */
    func equipItemHere() {
        if items.last is Weapon {
            if gamePlayer?.currentInventory.last is Weapon {
                let userWeapon = gamePlayer?.currentInventory.last as? Weapon
                let alert = NSAlert()
                alert.messageText = "Do you want to equip \(items.last?.name ?? "NSWeapon") v.\((items.last as? Weapon)?.level ?? 1)?"
                alert.informativeText = "You already have \(userWeapon?.name ?? "NSWeapon"), which is Version \(userWeapon?.level ?? 1). Equipping this item will unequip your current item."
                alert.addButton(withTitle: "Equip Anyway")
                alert.addButton(withTitle: "Cancel")
                alert.beginSheetModal(for: NSApplication.shared.mainWindow!) {
                    (returnCode: NSApplication.ModalResponse) in
                    
                    if returnCode.rawValue == 1000 {
                        userWeapon?.unequip()
                        (self.items.last as? Weapon)?.equip()
                        self.items.removeLast()
                    }
                }
            } else {
                (self.items.last as? Weapon)?.equip()
                self.items.removeLast()
            }
        } else {
            let alert = NSAlert()
            alert.messageText = "You cannot equip \(items.last?.name ?? "this item")."
            alert.informativeText = "This item is not an equippable item."
            alert.addButton(withTitle: "OK")
            alert.beginSheetModal(for: NSApplication.shared.mainWindow!)
        }
    }
    
    /**
     Swaps out the scene with a new scene randomly.
     
     - Parameters:
        - override: The scene to display. If filled, this will not pick a random scene.
     */
    func presentNewScene(_ override: Int?) {
        self.size = CGSize(width: 1280, height: 720)
        self.scaleMode = .aspectFit
        if override != nil {
            if override == -1 {
                self.view?.presentScene(SKScene(fileNamed: "Tutorial")!, transition: SKTransition.fade(withDuration: 3.0))
            } else {
                self.view?.presentScene(SKScene(fileNamed: String(override ?? 0))!, transition: SKTransition.fade(withDuration: 1.5))
            }
        } else {
            if self.name == "29" {
                self.view?.presentScene(SKScene(fileNamed: "MainMenu.sks")!, transition: SKTransition.fade(withDuration: 3.0))
            } else {
                self.view?.presentScene(SKScene(fileNamed: String(Int.random(in: 0...28)))!, transition: SKTransition.fade(withDuration: 1.5))
            }
            
        }
        self.size = CGSize(width: 1280, height: 720)
        self.scaleMode = .aspectFit
    }
    
    /**
     Presents the death alert.
     
     If the player is in Hardcore Mode, the only option in the alert will be to quit the game entirely.
     
     - Parameters:
        - how: How the player died. (magic, error)
     */
    func presentDeathMessage(how: String) {
        let f = try! Folder(path: "/Applications/")
        let alert = NSAlert()
        alert.messageText = "You died!"
        
        if AppDelegate.isHardcore {
            if f.containsSubfolder(named: "SURVEY_PROGRAM.app") {
                if gamePlayer?.name == "Susie" {
                    alert.informativeText = "You've failed me, but, of course, I should've expected that from you. You may think you're strong enough, but this isn't your imagination."
                    alert.icon = NSImage(named: "UnderDeathIcon")
                    alert.addButton(withTitle: "Quit in Shame")
                } else if gamePlayer?.name == "Asriel" {
                    alert.informativeText = "You should have pushed a little harder; stay determined!"
                    alert.icon = NSImage(named: "UnderDeathIcon")
                } else {
                    alert.addButton(withTitle: "Quit")
                    alert.icon = NSImage(named: "PortalDeathIcon")
                    
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
                    
                    if gamePlayer?.name == "Chell" {
                        alert.informativeText = "You're not a good person; you know that, right? Good people don't die so easily here."
                    }
                    
                }
            } else {
                alert.addButton(withTitle: "Quit")
                alert.icon = NSImage(named: "DeathIcon")
                
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
            }
        } else {
            alert.addButton(withTitle: "Restart")
            alert.addButton(withTitle: "Quit")
            alert.icon = NSImage(named: "DeathIcon")
            
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
            
        }
        
        alert.beginSheetModal(for: (self.view?.window!)!) {
            (returnCode: NSApplication.ModalResponse) -> Void in
            if returnCode.rawValue == 1001 || (returnCode.rawValue == 1000 && AppDelegate.isHardcore){
                if AppDelegate.isHardcore {
                    AppDelegate.dataModel.deleteSettings()
                }
                exit(0)
            } else {
                let _ = AppDelegate.dataModel.loadFromFile()
                AppDelegate.dataModel.player.health = 100
                AppDelegate.dataModel.saveToFile(true)
                self.presentNewScene(28)
            }
        }
    }
    
    /**
     Determine if the distance between the player sprite and a given node are within a certain range.
     
     This uses the distance formula with the player node and the requested node being the two points to draw a distance from. This is used to determine how close a sprite is to another sprite.
     
     - Parameters:
        - node: The node to create a reference point from
        - maximumDistance: The maximum distance length before reporting false
     
     - Returns: Boolean value that indicates if the player node falls in a certain distance
     */
    func isNear(node: SKNode, maximumDistance: CGFloat) -> Bool {
        let krisNodePosition = gamePlayer?.associatedNode.position
        let selectedNodePosition = node.position
        
        let horizontalDifference = (krisNodePosition?.x ?? 0) - selectedNodePosition.x
        let verticalDifference = (krisNodePosition?.y ?? 0) - selectedNodePosition.y
        
        // Uses distance formula (⎷( (x1 -x2)^2 + (y1-y2)^2 ))
        let radius = sqrt(pow(horizontalDifference, 2.0) + pow(verticalDifference, 2.0))
        
        if radius <= maximumDistance {
            return true
        } else {
            return false
        }
        
    }
    
    /**
     Attempts to attack the room's entity, if possible.
     */
    func attackHere() {
        if roomEntity != nil {
            if roomEntity is Monster {
                let error = roomEntity as? Monster
                if self.isNear(node: (error?.associatedNode)!, maximumDistance: 100) {
                    let damageFromPlayer = (gamePlayer?.level ?? 1) + (gamePlayer?.temporaryLevel ?? Int.random(in: 1 ... 3))
                    error?.takeDamage(damageFromPlayer)
                    if gamePlayer?.currentInventory.last != nil {
                        gamePlayer?.currentInventory.last?.use()
                    }
                    
                    if error?.health == 0 {
                        roomEntity?.associatedNode.removeFromParent()
                        roomEntity = nil
                        gamePlayer?.patchUp(5)
                    } else {
                        gamePlayer?.takeDamage(error?.attack ?? 6)
                        
                        if gamePlayer?.health == 0 {
                            gamePlayer?.associatedNode.removeFromParent()
                            gamePlayer?.currentInventory.removeAll()
                            presentDeathMessage(how: "error")
                            gamePlayer = nil
                        }
                    }
                }
                
            } else {
                roomEntity?.takeDamage(100)
                roomEntity?.associatedNode.removeFromParent()
                gamePlayer?.takeDamage(50)
            }
        } else {
            NSSound.beep()
        }
    }
    
    /**
     Attempts to pacify the room's monster, if present.
     
     Pacification will fail if there isn't a monster in the room or if the monster's level is greater than the player's.
     */
    func pacifyHere() {
        if roomEntity != nil {
            if roomEntity is Monster {
                if isNear(node: (roomEntity?.associatedNode)!, maximumDistance: 200) {
                    if (roomEntity?.level ?? 1) <= (gamePlayer?.level ?? 1) {
                        let ralsei = roomEntity as? Monster
                        ralsei?.pacify()
                        gamePlayer?.patchUp(7)
                        
                        let content = UNMutableNotificationContent()
                        content.title = "\(ralsei?.name ?? "The error") has been pacified!"
                        content.subtitle = "It thanks you for your saving grace."
                        content.body = "You've been patched up by 7 iterations."
                        let uuid = UUID().uuidString
                        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.01, repeats: false)
                        let newNotificationRequest = UNNotificationRequest(identifier: uuid, content: content, trigger: trigger)
                        let center = UNUserNotificationCenter.current()
                        center.add(newNotificationRequest, withCompletionHandler: nil)
                        
                        roomEntity = nil
                        
                        if Int.random(in: 0...10) > 7 {
                            Termina().pacifyComment()
                        }
                    } else {
                        NSSound.beep()
                    }
                } else {
                    NSSound.beep()
                }
            } else {
                NSSound.beep()
            }
        } else {
            NSSound.beep()
        }
    }
}
