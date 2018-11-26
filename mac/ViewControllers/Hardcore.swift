//
//  Hardcore.swift
//  Termina
//
//  Created by Marquis Kurt on 11/24/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

import Foundation
import Cocoa

class HardcoreViewController: NSViewController {
    
    @IBOutlet weak var playerNameField: NSTextField!
    
    @IBAction func submitAndDismiss(_ sender: Any) {
        let f = try! Folder(path: "/Applications/")
        
        AppDelegate.dataModel.player = Player(name: playerNameField.stringValue)
        
        if f.containsSubfolder(named: "SURVEY_PROGRAM.app") {
            if playerNameField.stringValue == "Susie" {
                AppDelegate.dataModel.player.level = 10
                Termina().targetSusie()
            } else if playerNameField.stringValue == "Asriel" {
                AppDelegate.dataModel.player.level = 30
                Termina().targetAsriel()
            }
        }
        
        AppDelegate.dataModel.backupSettings()
        AppDelegate.dataModel.saveToFile(true)
        AppDelegate.isHardcore = true
        dismiss(sender)
    }
    
    @IBAction func cancelAndDismiss(_ sender: Any) {
        dismiss(sender)
    }
    @IBAction func useExistingAndDismiss(_ sender: Any) {
        AppDelegate.dataModel.backupSettings()
        AppDelegate.dataModel.resetSettings()
        AppDelegate.isHardcore = true
        dismiss(sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
}
