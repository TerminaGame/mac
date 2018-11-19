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
    
    // Important vars
    var currentHealth: Int = 0
    var currentLevel: Int = 1
    var playerName: String = "Henry"
    
    
    func updateHealthStatus(number: Int) {
        
        if number <= 0 {
            currentHealth = 0
        }
        
        healthHUDNumber?.text = String(currentHealth)
        
        if number > 90 {
            healthHUD?.texture = SKTexture(imageNamed: "100")
        } else if number > 80 {
            healthHUD?.texture = SKTexture(imageNamed: "90")
        } else if number > 70 {
            healthHUD?.texture = SKTexture(imageNamed: "80")
        } else if number > 60 {
            healthHUD?.texture = SKTexture(imageNamed: "70")
        } else if number > 50 {
            healthHUD?.texture = SKTexture(imageNamed: "60")
        } else if number > 40 {
            healthHUD?.texture = SKTexture(imageNamed: "50")
        } else if number > 30 {
            healthHUD?.texture = SKTexture(imageNamed: "40")
        } else if number > 20 {
            healthHUD?.texture = SKTexture(imageNamed: "30")
        } else if number > 10 {
            healthHUD?.texture = SKTexture(imageNamed: "20")
        } else if number > 0 {
            healthHUD?.texture = SKTexture(imageNamed: "10")
        } else {
            healthHUD?.texture = SKTexture(imageNamed: "0")
        }
        
    }
    
    func updateLevelBadge(number: Int) {
        currentLevel = number
        levelBadgeNumber?.text = String(currentLevel)
    }
    
    func updatePlayerHUD(health: Int, level: Int) {
        updateHealthStatus(number: health)
        updateLevelBadge(number: level)
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
    }
    
    override func didMove(to view: SKView) {
        self.setUpScene()
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
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
        
        if currentHealth >= 0 {
            updateHealthStatus(number: currentHealth)
        }
        
        updateLevelBadge(number: currentLevel)
        
    }
    
}

