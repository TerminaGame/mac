//
//  PreferencesViewController.swift
//  Termina for macOS
//
//  Created by Marquis Kurt on 12/3/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

import Cocoa

class PreferencesViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        self.preferredContentSize = NSMakeSize(self.view.frame.width, self.view.frame.height)
        
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        self.view.window?.title = self.title!
    }
}
