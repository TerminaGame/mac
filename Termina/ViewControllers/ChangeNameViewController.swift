//
//  ChangeNameViewController.swift
//  Termina for macOS
//
//  Created by Marquis Kurt on 12/2/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

import Foundation
import Cocoa

class ChangeNameViewController: NSViewController {
    
    @IBOutlet weak var newNameField: NSTextField!
    
    var newName: String = ""
    
    @IBAction func dismissThisView(_ sender: Any) {
        dismiss(sender)
    }
    
    /**
     Change the name of the player and then dismiss the sheet.
     */
    @IBAction func changeNameAndDismiss(_ sender: Any) {
        newName = newNameField.stringValue
        AppDelegate.dataModel.player.name = newName
        AppDelegate.dataModel.saveToFile(false)
        AppDelegate.dataModel.player.associatedHud.updateName(newName)
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
