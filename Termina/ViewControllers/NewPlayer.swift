//
//  NewPlayer.swift
//  Termina for macOS
//
//  Created by Marquis Kurt on 11/23/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

import Foundation
import Cocoa

class NewPlayer: NSViewController {
    @IBOutlet weak var playerNameField: NSTextField!
    
    /**
     Cancels the operation and dismisses the sheet.
     */
    @IBAction func cancelAndDismiss(_ sender: Any) {
        dismiss(sender)
    }
    
    /**
     Proceeds with importing a player's settings and dismisses the sheet.
     */
    @IBAction func importAndDismiss(_ sender: Any) {
        dismiss(sender)
        AppDelegate.dataModel.importSettings()
    }
    
    /**
     Takes the input from the sheet, creates player data, and then dismisses the sheet.
     */
    @IBAction func submitAndDismiss(_ sender: Any) {
        AppDelegate.dataModel.player = Player(name: playerNameField.stringValue)
        AppDelegate.dataModel.saveToFile(true)
        if AppDelegate.dataModel.loadFromFile() {
            AppDelegate.gotLoadedData = true
        }
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
