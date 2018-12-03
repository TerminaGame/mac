//
//  PreferencesWindowController.swift
//  Termina
//
//  Created by Marquis Kurt on 12/3/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

import Cocoa

class PreferencesWindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
    
    func windowShouldClose(_ sender: NSWindow) -> Bool {
        self.window?.orderOut(sender)
        return false
    }

}
