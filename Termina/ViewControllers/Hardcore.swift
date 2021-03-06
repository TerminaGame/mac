//
//  Hardcore.swift
//  Termina for macOS
//
//  Created by Marquis Kurt on 11/24/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

import Foundation
import Cocoa
import Files

class HardcoreViewController: NSViewController {
    
    @IBOutlet weak var playerNameField: NSTextField!
    
    /**
     Takes the player's input, parses it, creates the temporary player data, and then dismisses the sheet
     */
    @IBAction func submitAndDismiss(_ sender: Any) {
        let f = try! Folder(path: "/Applications/")
        
        AppDelegate.dataModel.player = Player(name: playerNameField.stringValue)
        
        if playerNameField.stringValue == "Termina" {
            TerminaEntity().mockPlayerHardcore()
            exit(0)
        } else if f.containsSubfolder(named: "SURVEY_PROGRAM.app") {
            if playerNameField.stringValue == "Susie" {
                AppDelegate.dataModel.player.level = 10
                TerminaEntity().targetSusie()
            } else if playerNameField.stringValue == "Asriel" {
                AppDelegate.dataModel.player.level = 30
                TerminaEntity().targetAsriel()
            }
        }
        
        AppDelegate.dataModel.backupSettings()
        AppDelegate.dataModel.saveToFile(true)
        AppDelegate.isHardcore = true
        dismiss(sender)
    }
    
    /**
     Cancels the operation and dismisses the sheet
     */
    @IBAction func cancelAndDismiss(_ sender: Any) {
        dismiss(sender)
    }
    
    /**
     Creates a backup of the player data, resets the settings, and then dismisses the sheet.
     */
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
