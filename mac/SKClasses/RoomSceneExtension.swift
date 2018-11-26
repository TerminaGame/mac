//
//  RoomSceneExtension.swift
//  Termina
//
//  Created by Marquis Kurt on 11/20/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

import Foundation
import SpriteKit

extension RoomScene {
    
    override func mouseDown(with event: NSEvent) {
        
    }
    
    override func mouseDragged(with event: NSEvent) {
        
    }
    
    override func mouseUp(with event: NSEvent) {
        attackHere()
    }
    
    override func rightMouseUp(with event: NSEvent) {
        if (roomEntity?.level ?? 1) > (gamePlayer?.level ?? 1) {
            pacifyHere()
        }
        
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

