//
//  GeneralPane.swift
//  Termina
//
//  Created by Marquis Kurt on 12/13/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

import Cocoa

class GeneralPane: PreferencesViewController {

    @IBOutlet weak var saveOnLevelUp: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        if TerminaUserDefaults.shouldSaveOnLevelUp {
            saveOnLevelUp.state = .on
        } else {
            saveOnLevelUp.state = .off
        }
    }
    
    override func viewWillDisappear() {
        if saveOnLevelUp.state == .on {
            TerminaUserDefaults().toggleLevelSaves(to: true)
        } else {
            TerminaUserDefaults().toggleLevelSaves(to: false)
        }
    }
    
}
