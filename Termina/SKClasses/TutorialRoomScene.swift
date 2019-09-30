//
//  Room29Scene.swift
//  Termina for macOS
//
//  Created by Marquis Kurt on 11/23/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

import Foundation
import SpriteKit

/**
 Overriding class for the tutorial room
 */
class TutorialRoomScene: RoomScene {
    
    override func setUpScene() {
        self.size = CGSize(width: 1280, height: 720)
        
        setUpPlayer()
        
        configureTileMap(childNode(withName: "baseTilemap") as! SKTileMapNode, movable: false)
        if childNode(withName: "movableTiles") != nil {
            configureTileMap(childNode(withName: "movableTiles") as! SKTileMapNode, movable: true)
        }
        
        exitRoom = childNode(withName: "exitRoomNode") as? SKSpriteNode
        
        /*
            Patch the player up immediately on wake up and save settings. This prevents the player
            from accidentally being in the tutorial room again.
         
            Not that butterscotch pie is gross or anything...
         */
        gamePlayer?.patchUp(1)
        AppDelegate.dataModel.saveToFile(true)
        
        
    }
}

