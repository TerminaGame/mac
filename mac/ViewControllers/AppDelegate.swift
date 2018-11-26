//
//  AppDelegate.swift
//  mac
//
//  Created by Marquis Kurt on 11/18/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

import Foundation
import Cocoa
import UserNotifications
import SpriteKit

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, UNUserNotificationCenterDelegate {
    
    static var dataModel = DataModel(whichPlayer: Player(name: "Frisk"))
    static var gotLoadedData = false
    static var isHardcore = false
    @IBOutlet weak var resetMenuItem: NSMenuItem!
    @IBOutlet weak var deleteMenuItem: NSMenuItem!
    
    @IBAction func getAboutSheet(_ sender: Any) {
        NSApplication.shared.mainWindow?.contentViewController?.presentAsSheet(NSStoryboard(name: "About", bundle: Bundle.main).instantiateController(withIdentifier: "About") as! NSViewController)
    }

    @IBAction func getPlayerInfo(_ sender: Any) {
        NSApplication.shared.mainWindow?.contentViewController?.presentAsSheet(NSStoryboard(name: "Profile", bundle: Bundle.main).instantiateController(withIdentifier: "Profile") as! NSViewController)
    }
    
    
    @IBAction func importSettingsFIle(_ sender: Any) {
        AppDelegate.dataModel.importSettings()
    }
    
    @IBAction func saveDataFromMenu(_ sender: Any) {
        AppDelegate.dataModel.saveToFile(false)
    }
    
    @IBAction func resetPlayerData(_ sender: Any) {
        let alert = NSAlert()
        alert.alertStyle = NSAlert.Style.warning
        alert.messageText = "Are you sure you want to reset your player data?"
        alert.informativeText = "This action cannot be reversed."
        alert.addButton(withTitle: "Reset")
        alert.addButton(withTitle: "Cancel")
        let response = alert.runModal()
        
        if response.rawValue == 1000 {
            AppDelegate.dataModel.resetSettings()
        }
    }
    
    @IBAction func deletePlayerData(_ sender: Any) {
        let alert = NSAlert()
        alert.alertStyle = NSAlert.Style.critical
        alert.messageText = "Are you sure you want to delete your player data?"
        alert.informativeText = "This action cannot be reversed."
        alert.addButton(withTitle: "Delete")
        alert.addButton(withTitle: "Cancel")
        let response = alert.runModal()
        
        if response.rawValue == 1000 {
            AppDelegate.dataModel.deleteSettings()
        }
    }
    
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        AppDelegate.gotLoadedData = AppDelegate.dataModel.loadFromFile()
        if !(AppDelegate.dataModel.appDataPath.containsFile(named: "settings.json")) {
            resetMenuItem.isEnabled = false
            deleteMenuItem.isEnabled = false
        } else {
            resetMenuItem.isEnabled = true
            deleteMenuItem.isEnabled = true
        }
        
        if AppDelegate.dataModel.appDataPath.containsFile(named: "settings_backup.json") {
            let alert = NSAlert()
            alert.messageText = "Do you want to restore the backup file?"
            alert.informativeText = "Termina detected a backup file, which may have been created during Hardcore Mode. Do you want to restore this file?"
            alert.addButton(withTitle: "Restore")
            alert.addButton(withTitle: "Cancel")
            let response = alert.runModal()
            
            if response.rawValue == 1000 {
                try! AppDelegate.dataModel.appDataPath.file(named: "settings_backup.json").rename(to: "settings.json")
                let _ = AppDelegate.dataModel.loadFromFile()
            }
        }
    }
    
    func applicationShouldTerminate(_ sender: NSApplication) -> NSApplication.TerminateReply {
        if AppDelegate.dataModel.appDataPath.containsFile(named: "settings.json") {
            let alert = NSAlert()
            alert.messageText = "Are you sure you want to quit the game?"
            alert.informativeText = "Any unsaved progress will be lost. If you are in Hardcore Mode, your data will not be saved."
            
            alert.addButton(withTitle: "Quit")
            alert.addButton(withTitle: "Cancel")
            let response = alert.runModal().rawValue
            
            if response == 1000 {
                if AppDelegate.dataModel.appDataPath.containsFile(named: "settings.json") && !AppDelegate.isHardcore {
                    AppDelegate.dataModel.saveToFile(false)
                } else if AppDelegate.isHardcore {
                    AppDelegate.dataModel.deleteSettings()
                    if AppDelegate.dataModel.appDataPath.containsFile(named: "settings_backup.json") {
                        try! AppDelegate.dataModel.appDataPath.file(named: "settings_backup.json").rename(to: "settings.json")
                    }
                }
                return NSApplication.TerminateReply.terminateNow
            } else {
                return NSApplication.TerminateReply.terminateCancel
            }
        } else {
            return NSApplication.TerminateReply.terminateNow
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
    
    func applicationWillTerminate(_ aNotification: Notification) { }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
    
}
