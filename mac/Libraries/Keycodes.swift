//
//  Keycodes.swift
//  Termina
//
//  Created by Marquis Kurt on 11/19/18.
//  Copyright © 2018 Bojan Percevic (edited by Marquis Kurt). All rights reserved.
//

import Foundation
import SpriteKit

enum Key: CUnsignedShort {
    case W = 0x0D
    case A = 0x00
    case S = 0x01
    case D = 0x02
    case space = 0x31
    case E = 0x0E
    case K = 0x28
    case Count = 0x7F
    case Esc = 0x35
    case Command = 0x37
}

struct KeyState {
    var keys = [Bool](repeating: false, count: Int(Key.Count.rawValue))
}

class Keyboard {
    
    static let sharedKeyboard = Keyboard()
    
    var prev: KeyState
    var curr: KeyState
    
    init() {
        prev = KeyState()
        curr = KeyState()
    }
    
    func handleKey(event: NSEvent, isDown: Bool) {
        if (isDown) {
            curr.keys[Int(event.keyCode)] = true
        } else {
            curr.keys[Int(event.keyCode)] = false
        }
    }
    
    func justPressed(keys: Key...) -> Bool {
        for key in keys {
            if (curr.keys[Int(key.rawValue)] == true && prev.keys[Int(key.rawValue)] == false) {
                return true
            }
        }
        return false
    }
    
    func justReleased(keys: Key...) -> Bool {
        for key in keys {
            if (prev.keys[Int(key.rawValue)] == true && curr.keys[Int(key.rawValue)] == false) {
                return true
            }
        }
        return false
    }
    
    func pressed(keys: Key...) -> Bool {
        for key in keys {
            if (prev.keys[Int(key.rawValue)] == true && curr.keys[Int(key.rawValue)] == true) {
                return true
            }
        }
        return false
    }
    
    func update() {
        prev = curr
    }
    
}
