//
//  Data.swift
//  Termina
//
//  Created by Marquis Kurt on 11/23/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

import Foundation
import SpriteKit
import UserNotifications
import AppCenterCrashes
import AppCenterAnalytics
import AppCenter

/**
 Class responsible for managing player data
 */
class DataModel {
    
    /**
     The player to import, create, save, or load settings for
     */
    var player: Player
    
    /**
     Temporary stored level value (used when restoring from Hardcore Mode)
     */
    var storedLevel: Int = 0
    
    /**
     The data path where Termina's data files are located.
     
     Termina runs in a sandbox, so the default directory is in the user's Library of containers (`/Users/<username>/Library/Containers/io.github.terminagame.mac/Data/`)
     */
    let appDataPath = try! Folder(path: Folder.home.path)
    
    /**
     Attempts to load data from the folder.
     */
    func loadFromFile() -> Bool {
        if (appDataPath.containsFile(named: "settings.json")) {
            do {
                let settingsFile = try appDataPath.file(named: "settings.json").readAsString()
                let json = JSON.init(parseJSON: settingsFile)
                player.name = json["name"].string!
                player.level = Int(json["level"].string!)!
                player.patchNumber = Int(json["progress"].string!)!
                
                if Double(json["health"].string!)! >= 100 {
                    player.health = 100
                    saveToFile(true)
                } else if Double(json["health"].string!)! == 0.0 {
                    player.health = 100
                    saveToFile(true)
                } else {
                    player.health = Int(Double(json["health"].string!)!)
                }
                
                AppDelegate.gotLoadedData = true
                
                return true
            } catch {
                if BetaHandler.isBetaBuild && TerminaUserDefaults.sendBetaAnalytics {
                    MSAnalytics.trackEvent("Failed to load settings file. Reason: \(error)")
                }
                return false
            }
        } else {
            if TerminaUserDefaults.canSendNotifications && TerminaUserDefaults.canSendDataNotifications {
                let content = UNMutableNotificationContent()
                content.title = "Player Data Missing"
                content.subtitle = "Termina couldn't locate your player data."
                content.body = "If you are starting a new game, you can ignore this message."
                let uuid = UUID().uuidString
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.01, repeats: false)
                let newNotificationRequest = UNNotificationRequest(identifier: uuid, content: content, trigger: trigger)
                let center = UNUserNotificationCenter.current()
                center.add(newNotificationRequest, withCompletionHandler: nil)
            }
            return false
        }
    }
    
    /**
     Attempts to save the file to the data folder.
     */
    func saveToFile(_ silent: Bool) {
        do {
            try appDataPath.createFile(named: "settings.json", contents: """
                {
                "name": "\(player.name)",
                "level": "\(player.level)",
                "progress": "\(player.patchNumber)",
                "health": "\(Double(player.health))"
                }
                """)
        } catch {
            if BetaHandler.isBetaBuild && TerminaUserDefaults.sendBetaAnalytics {
                MSAnalytics.trackEvent("Failed to save settings file. Reason: \(error)")
            }
        }
        
        
        
        if !silent {
            if TerminaUserDefaults.canSendNotifications && TerminaUserDefaults.canSendDataNotifications {
                let content = UNMutableNotificationContent()
                content.title = "Player Data Saved"
                content.subtitle = player.name
                content.body = "Your player data has been saved."
                let uuid = UUID().uuidString
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.01, repeats: false)
                let newNotificationRequest = UNNotificationRequest(identifier: uuid, content: content, trigger: trigger)
                let center = UNUserNotificationCenter.current()
                center.add(newNotificationRequest, withCompletionHandler: nil)
            }
        }
        
    }
    
    /**
     Resets the settings to default values, with the exception of the player's name.
     */
    func resetSettings() {
        player.level = 1
        player.patchNumber = 0
        player.health = 100
        saveToFile(false)
        let content = UNMutableNotificationContent()
        content.title = "Player Data Reset"
        content.body = "Your player data has been reset."
        let uuid = UUID().uuidString
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.01, repeats: false)
        let newNotificationRequest = UNNotificationRequest(identifier: uuid, content: content, trigger: trigger)
        let center = UNUserNotificationCenter.current()
        center.add(newNotificationRequest, withCompletionHandler: nil)
    }
    
    /**
     Attempts to delete the settings file.
     */
    func deleteSettings() {
        if (appDataPath.containsFile(named: "settings.json")) {
            do {
                try appDataPath.file(named: "settings.json").delete()
                
                if TerminaUserDefaults.canSendNotifications && TerminaUserDefaults.canSendDataNotifications {
                    let content = UNMutableNotificationContent()
                    if appDataPath.containsFile(named: "settings_backup.json") || AppDelegate.isHardcore {
                        content.title = "Hardcore Mode Data Deleted"
                        content.body = "Hardcore Mode data has been deleted."
                    } else {
                        content.title = "Player Data Deleted"
                        content.body = "Your player data has been deleted."
                    }
                    let uuid = UUID().uuidString
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.01, repeats: false)
                    let newNotificationRequest = UNNotificationRequest(identifier: uuid, content: content, trigger: trigger)
                    let center = UNUserNotificationCenter.current()
                    center.add(newNotificationRequest, withCompletionHandler: nil)
                }
                
                
                
                do {
                    try appDataPath.file(named: "settings_backup.json").rename(to: "settings.json")
                } catch {
                    if BetaHandler.isBetaBuild && TerminaUserDefaults.sendBetaAnalytics {
                        MSAnalytics.trackEvent("Failed to Rename backup. Reason: \(error)")
                    }
                }
            } catch {
                if BetaHandler.isBetaBuild && TerminaUserDefaults.sendBetaAnalytics {
                    MSAnalytics.trackEvent("Failed to delete settings file. Reason: \(error)")
                }
                
                if TerminaUserDefaults.canSendNotifications && TerminaUserDefaults.canSendDataNotifications {
                    let content = UNMutableNotificationContent()
                    content.title = "Couldn't Delete Settings"
                    content.body = "We couldn't delete your settings."
                    let uuid = UUID().uuidString
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.01, repeats: false)
                    let newNotificationRequest = UNNotificationRequest(identifier: uuid, content: content, trigger: trigger)
                    let center = UNUserNotificationCenter.current()
                    center.add(newNotificationRequest, withCompletionHandler: nil)
                }
            }
        }
    }
    
    /**
     Attempts to make a backup copy of the settings file.
     */
    func backupSettings() {
        if appDataPath.containsFile(named: "settings.json") {
            do {
                try appDataPath.file(named: "settings.json").rename(to: "settings_backup.json")
            } catch {
                if BetaHandler.isBetaBuild && TerminaUserDefaults.sendBetaAnalytics {
                    MSAnalytics.trackEvent("Failed to backup settings file. Reason: \(error)")
                }
                let alert = NSAlert()
                alert.alertStyle = NSAlert.Style.critical
                alert.messageText = "We couldn't use back up data."
                alert.informativeText = "Something went wrong when trying to back up your data."
                alert.addButton(withTitle: "OK")
                alert.runModal()
            }
        }
    }
    
    /**
     Attempts to restore the settings file from a backup.
     */
    func restoreSettings() {
        if appDataPath.containsFile(named: "settings_backup.json") && !(appDataPath.containsFile(named: "settings.json")) {
            do {
                try appDataPath.file(named: "settings_backup.json").rename(to: "settings.json")
            } catch {
                if BetaHandler.isBetaBuild && TerminaUserDefaults.sendBetaAnalytics {
                    MSAnalytics.trackEvent("Failed to restore settings file. Reason: \(error)")
                }
                let alert = NSAlert()
                alert.alertStyle = NSAlert.Style.critical
                alert.messageText = "We couldn't restore your data."
                alert.informativeText = "Something went wrong when trying to restore your data."
                alert.addButton(withTitle: "OK")
                alert.runModal()
            }
        } else {
            deleteSettings()
            do {
                try appDataPath.file(named: "settings_backup.json").rename(to: "settings.json")
            } catch {
                if BetaHandler.isBetaBuild && TerminaUserDefaults.sendBetaAnalytics {
                    MSAnalytics.trackEvent("Failed to rename settings file. Reason: \(error)")
                }
                let alert = NSAlert()
                alert.alertStyle = NSAlert.Style.critical
                alert.messageText = "We couldn't restore your data."
                alert.informativeText = "Something went wrong when trying to restore your data."
                alert.addButton(withTitle: "OK")
                alert.runModal()
            }
        }
    }
    
    /**
     Attempts to import the settings file a player selects from an NSOpenPanel
     */
    func importSettings() {
        let importFilePathDialog = NSOpenPanel()
        importFilePathDialog.title = "Import Data"
        importFilePathDialog.prompt = "Choose"
        importFilePathDialog.message = "Choose the player data to import. If you have started a game already, this will overwrite your settings."
        importFilePathDialog.showsResizeIndicator = true
        importFilePathDialog.canChooseFiles = true
        importFilePathDialog.canCreateDirectories = true
        importFilePathDialog.canChooseDirectories = false
        importFilePathDialog.showsHiddenFiles = false
        importFilePathDialog.allowsMultipleSelection = false
        importFilePathDialog.allowedFileTypes = ["json"]
        
        importFilePathDialog.beginSheetModal(for: NSApplication.shared.mainWindow!) {
            (completionHandler: NSApplication.ModalResponse) -> Void in
            
            if completionHandler == NSApplication.ModalResponse.OK {
                let importFilePath = importFilePathDialog.url
                
                if importFilePath != nil {
                    let path = importFilePath!.path.replacingOccurrences(of: "/settings.json", with: "")
                    let importPathDirectory = try! Folder(path: path)
                    
                    if self.appDataPath.containsFile(named: "settings.json") {
                        do {
                            try self.appDataPath.file(named: "settings.json").delete()
                        } catch {
                            if BetaHandler.isBetaBuild && TerminaUserDefaults.sendBetaAnalytics {
                                MSAnalytics.trackEvent("Failed to delete settings file. Reason: \(error)")
                            }
                        }
                    }
                    try! importPathDirectory.file(named: "settings.json").copy(to: self.appDataPath)
                    let _ = self.loadFromFile()
                    
                    if TerminaUserDefaults.canSendNotifications && TerminaUserDefaults.canSendDataNotifications {
                        let content = UNMutableNotificationContent()
                        content.title = "Data Import Successful"
                        content.body = "Your player data has been imported."
                        let uuid = UUID().uuidString
                        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.01, repeats: false)
                        let newNotificationRequest = UNNotificationRequest(identifier: uuid, content: content, trigger: trigger)
                        let center = UNUserNotificationCenter.current()
                        center.add(newNotificationRequest, withCompletionHandler: nil)
                    }
                }
                
            }
        }
    }
    
    /**
     Initializes the DataModel class.
     
     - Parameters:
        - whichPlayer: The player to associate with a data model
     */
    init(whichPlayer: Player) {
        player = whichPlayer
    }
    
}
