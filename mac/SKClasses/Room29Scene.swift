//
//  Room29Scene.swift
//  Termina
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
        
        configureTileMap(map: childNode(withName: "baseTilemap") as! SKTileMapNode, movable: false)
        if childNode(withName: "movableTiles") != nil {
            configureTileMap(map: childNode(withName: "movableTiles") as! SKTileMapNode, movable: true)
        }
        
        
        if childNode(withName: "enemyNode") != nil { setUpEntity() }
        
        
    }
}

