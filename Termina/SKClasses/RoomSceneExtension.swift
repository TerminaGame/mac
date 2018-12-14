//
//  RoomSceneExtension.swift
//  Termina for macOS
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
        if (roomEntity?.level ?? 1) <= (gamePlayer?.level ?? 1) {
            if !AppDelegate.isHardcore {
                pacifyHere()
            } else {
                let alert = NSAlert()
                alert.messageText = "Not so fast."
                alert.informativeText = "Did you really think I'd let you do that in Hardcore Mode? Think again."
                alert.addButton(withTitle: "OK")
                alert.runModal()
            }
            
        } else if roomEntity == nil {
            let alert = NSAlert()
            alert.messageText = "You can't pacify here."
            alert.informativeText = "There's nothing to pacify in this room."
            alert.addButton(withTitle: "OK")
            alert.beginSheetModal(for: NSApplication.shared.mainWindow!)
        }
        
    }
    
    override func didFinishUpdate() {
        Keyboard.sharedKeyboard.update()
    }
    
    override func keyDown(with event: NSEvent) {
        if gamePlayer?.health == 0 {
            Keyboard.sharedKeyboard.handleKey(event: event, isDown: false)
        } else {
            Keyboard.sharedKeyboard.handleKey(event: event, isDown: true)
        }
        
    }
    
    override func keyUp(with event: NSEvent) {
        Keyboard.sharedKeyboard.handleKey(event: event, isDown: false)
    }
    
}

