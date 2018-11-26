//
//  Profile.swift
//  Termina
//
//  Created by Marquis Kurt on 11/24/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

import Foundation
import Cocoa
import SpriteKit

class ProfileViewController: NSViewController {
    @IBOutlet weak var playerName: NSTextField!
    @IBOutlet weak var playerProgress: NSTextField!
    @IBOutlet weak var playerHealth: NSTextField!
    @IBOutlet weak var currentWeapon: NSTextField!
    @IBOutlet weak var dropWeaponButton: NSButton!
    
    @IBAction func dismissProfile(_ sender: Any) {
        dismiss(sender)
    }
    @IBAction func dropWeapon(_ sender: Any) {
        let alert = NSAlert()
        alert.alertStyle = NSAlert.Style.critical
        alert.messageText = "Are you sure you want to drop \(AppDelegate.dataModel.player.currentInventory.first?.name ?? "NSWeapon")?"
        alert.informativeText = "This action cannot be reversed."
        alert.addButton(withTitle: "Drop")
        alert.addButton(withTitle: "Cancel")
        alert.beginSheetModal(for: (NSApplication.shared.mainWindow)!) {
            (returnCode: NSApplication.ModalResponse) -> Void in
            if returnCode.rawValue == 1000 {
                (AppDelegate.dataModel.player.currentInventory.first as? Weapon)?.unequip()
            }
        }
        dismiss(sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerName.stringValue = AppDelegate.dataModel.player.name
        playerProgress.stringValue = "Version \(AppDelegate.dataModel.player.level).\(AppDelegate.dataModel.player.patchNumber)"
        playerHealth.stringValue = "\(AppDelegate.dataModel.player.health)%"
        
        let inventory = AppDelegate.dataModel.player.currentInventory
        print(inventory)
        
        if inventory.isEmpty {
            currentWeapon.stringValue = "No items being carried."
            dropWeaponButton.isHidden = true
        } else {
            currentWeapon.stringValue = "Current Weapon: \(inventory.first?.name ?? "NSWeapon") (v. \(((inventory.first) as? Weapon)?.level ?? 1))"
        }
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
}