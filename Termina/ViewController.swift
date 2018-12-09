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
                
        if let view = self.skView {
            
            if let scene = SKScene(fileNamed: "MainMenu") {
                scene.name = "mainMenu"
                scene.scaleMode = .aspectFit
                //view.presentScene(scene)
                view.presentScene(scene, transition: SKTransition.fade(withDuration: 3.0))
            }
            
            view.ignoresSiblingOrder = true
            
            if BetaHandler.isBetaBuild && TerminaUserDefaults.displayBetaInformation {
                view.showsFPS = true
                view.showsNodeCount = true
            }
            
        }
    }
    
    override func viewWillAppear() {
        if BetaHandler.isBetaBuild && TerminaUserDefaults.displayBetaInformation {
            self.skView.showsFPS = true
            self.skView.showsNodeCount = true
        }
        
        if TerminaUserDefaults.demoMode {
            self.skView.window?.title = "Termina - Demo Mode"
        }
    }
    
}

