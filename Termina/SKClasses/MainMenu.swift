//
//  MainMenu.swift
//  Termina
//
//  Created by Marquis Kurt on 11/23/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

import Foundation
import SpriteKit
import UserNotifications

class MainMenu: SKScene {
    
    var menuTitle: SKLabelNode?
    var startGameButton: SKLabelNode?
    var hardcoreButton: SKLabelNode?
    var resetButton: SKLabelNode?
    var quitButton: SKLabelNode?
    
    var background: SKSpriteNode?
    
    /**
     Changes the font of the SKLabelNodes to Apple's default system font
     */
    func getSystemFont() {
        menuTitle?.fontName = NSFont.boldSystemFont(ofSize: 72).fontName
        startGameButton?.fontName = NSFont.systemFont(ofSize: 32).fontName
        hardcoreButton?.fontName = NSFont.systemFont(ofSize: 32).fontName
        resetButton?.fontName = NSFont.systemFont(ofSize: 32).fontName
        quitButton?.fontName = NSFont.systemFont(ofSize: 32).fontName
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
            self.view?.presentScene(SKScene(fileNamed: String(override ?? 0))!, transition: SKTransition.fade(withDuration: 1.5))
        } else {
            let newRoom = String(Int.random(in: 0...28))
            self.view?.presentScene(SKScene(fileNamed: newRoom)!, transition: SKTransition.fade(withDuration: 1.5))
        }
        self.size = CGSize(width: 1280, height: 720)
        self.scaleMode = .aspectFit
    }
    
    /**
     Prompts the user to confirm resetting data (or gives option to delete it)
     */
    func resetPlayerData() {
        let alert = NSAlert()
        alert.messageText = "Are you sure you want to reset your player data?"
        alert.informativeText = "You cannot reverse this action."
        
        alert.addButton(withTitle: "Reset")
        alert.addButton(withTitle: "Delete")
        alert.addButton(withTitle: "Cancel")
        alert.beginSheetModal(for: (self.view?.window!)!) {
            (returnCode: NSApplication.ModalResponse) -> Void in
            if returnCode.rawValue == 1000 {
                AppDelegate.dataModel.resetSettings()
            } else if returnCode.rawValue == 1001 {
                self.deleteSettings()
            }
        }
    }
    
    /**
     Prompts the user to confirm deleting data
     */
    func deleteSettings() {
        let alert = NSAlert()
        alert.alertStyle = NSAlert.Style.critical
        alert.messageText = "Are you sure you want to delete your settings?"
        alert.informativeText = "You cannot reverse this action."
        
        alert.addButton(withTitle: "Delete")
        alert.addButton(withTitle: "Cancel")
        alert.beginSheetModal(for: (self.view?.window!)!) {
            (returnCode: NSApplication.ModalResponse) -> Void in
            if returnCode.rawValue == 1000 {
                AppDelegate.dataModel.deleteSettings()
                AppDelegate.gotLoadedData = false
            }
        }
    }
    
    /**
     Exits the application.
     */
    func quitGame() {
        exit(0)
    }
    
    /**
     Sets up the menu
     */
    func setUpMenu() {
        self.size = CGSize(width: 1280, height: 720)
        self.scaleMode = .aspectFit
        
        menuTitle = childNode(withName: "menuTitle") as? SKLabelNode
        startGameButton = childNode(withName: "startButton") as? SKLabelNode
        hardcoreButton = childNode(withName: "hardcoreButton") as? SKLabelNode
        resetButton = childNode(withName: "resetButton") as? SKLabelNode
        quitButton = childNode(withName: "quitButton") as? SKLabelNode
        background = childNode(withName: "mainMenuBackground") as? SKSpriteNode
        
        if !AppDelegate.gotLoadedData {
            resetButton?.isHidden = true
            startGameButton?.text = "Create Player"
        }
        
        getSystemFont()
        background?.texture = SKTexture(imageNamed: "mainMenu")
        
    }
    
    
    override func didMove(to view: SKView) {
        setUpMenu()
    }
    
    override func update(_ currentTime: TimeInterval) {
        self.size = CGSize(width: 1280, height: 720)
        self.scaleMode = .aspectFit
        if AppDelegate.gotLoadedData {
            startGameButton?.text = "Start Game"
            resetButton?.isHidden = false
        } else {
            startGameButton?.text = "Create Player"
            resetButton?.isHidden = true
        }
        
        if AppDelegate.isHardcore {
            startGameButton?.text = "Start Normal Game"
            hardcoreButton?.text = "Start Hardcore Game"
        }
        
        // Check if this is a beta. If not, hide the Beta Label.
        if !(BetaHandler.isBetaBuild) {
            childNode(withName: "betaLabel")?.isHidden = true
        }

    }
    
}

extension MainMenu {
    
    override func mouseUp(with event: NSEvent) {
        let clickLocation = event.location(in: self)
        let nodeClicked = self.nodes(at: clickLocation)
        for node in nodeClicked {
            if node is SKLabelNode {
                switch (node.name) {
                case "startButton":
                    if !AppDelegate.gotLoadedData {
                        self.view?.window?.contentViewController?.presentAsSheet(NSStoryboard(name: "NewPlayer", bundle: Bundle.main).instantiateController(withIdentifier: "NewPlayer") as! NSViewController)
                    } else {
                        self.size = CGSize(width: 1280, height: 720)
                        self.scaleMode = .aspectFit
                        presentNewScene(20)
                    }
                    break
                case "hardcoreButton":
                    if !AppDelegate.isHardcore {
                        self.view?.window?.contentViewController?.presentAsSheet(NSStoryboard(name: "Hardcore", bundle: Bundle.main).instantiateController(withIdentifier: "Hardcore") as! NSViewController)
                    } else {
                        self.size = CGSize(width: 1280, height: 720)
                        self.scaleMode = .aspectFit
                        presentNewScene(nil)
                    }
                    break
                case "resetButton":
                    resetPlayerData()
                    break
                case "quitButton":
                    quitGame()
                    break
                default:
                    break
                }
            }
        }
    }

}
