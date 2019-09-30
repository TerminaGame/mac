//
//  Room29Scene.swift
//  Termina for macOS
//
//  Created by Marquis Kurt on 11/23/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

import Foundation
import SpriteKit

class Room29Scene: RoomScene {
    
    override func setUpScene() {
        self.size = CGSize(width: 1280, height: 720)
        
        setUpBackground(29)
        
        setUpPlayer()
        
        configureTileMap(childNode(withName: "baseTilemap") as! SKTileMapNode, movable: false)
        if childNode(withName: "movableTiles") != nil {
            configureTileMap(childNode(withName: "movableTiles") as! SKTileMapNode, movable: true)
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
}

