//
//  GameViewController.swift
//  TerminaSK macOS
//
//  Created by Marquis Kurt on 11/17/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

import Cocoa
import SpriteKit
import GameplayKit

class ViewController: NSViewController {
    
    @IBOutlet var skView: SKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(TerminaUserDefaults.canSendNotifications)
        
        if let view = self.skView {
            
            if let scene = SKScene(fileNamed: "MainMenu") {
                scene.name = "mainMenu"
                scene.scaleMode = .aspectFit
                //view.presentScene(scene)
                view.presentScene(scene, transition: SKTransition.fade(withDuration: 3.0))
            }
            
            view.ignoresSiblingOrder = true
            
            if BetaHandler.isBetaBuild {
                view.showsFPS = true
                view.showsNodeCount = true
            }
            
        }
    }
    
}

