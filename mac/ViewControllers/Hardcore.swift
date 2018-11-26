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
        if playerNameField.stringValue == "Susie" && f.containsSubfolder(named: "SURVEY_PROGRAM.app") {
            let alert = NSAlert()
            alert.alertStyle = NSAlert.Style.critical
            alert.messageText = "So that's how we're playing it?"
            alert.informativeText = "Let's not forget who's in charge here. I expect nothing less from you."
            alert.addButton(withTitle: "OK")
            alert.runModal()
        }
        AppDelegate.dataModel.player = Player(name: playerNameField.stringValue)
        if AppDelegate.dataModel.player.name == "Susie" && f.containsSubfolder(named: "SURVEY_PROGRAM.app") {
            AppDelegate.dataModel.player.level = 10
        }
        if AppDelegate.dataModel.appDataPath.containsFile(named: "settings.json") {
            try! AppDelegate.dataModel.appDataPath.file(named: "settings.json").rename(to: "settings_backup.json")
        }
        AppDelegate.dataModel.saveToFile(true)
        AppDelegate.isHardcore = true
        dismiss(sender)
    }
    
    @IBAction func cancelAndDismiss(_ sender: Any) {
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
