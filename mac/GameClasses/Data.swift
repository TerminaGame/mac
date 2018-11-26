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

class DataModel {
    
    var player: Player
    var storedLevel: Int = 0
    let appDataPath = try! Folder(path: Folder.home.path)
    
    func loadFromFile() -> Bool {
        if (appDataPath.containsFile(named: "settings.json")) {
            let settingsFile = try! appDataPath.file(named: "settings.json").readAsString()
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
        } else {
            let content = UNMutableNotificationContent()
            content.title = "Player Data Missing"
            content.subtitle = "Termina couldn't locate your player data."
            content.body = "If you are starting a new game, you can ignore this message."
            let uuid = UUID().uuidString
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.01, repeats: false)
            let newNotificationRequest = UNNotificationRequest(identifier: uuid, content: content, trigger: trigger)
            let center = UNUserNotificationCenter.current()
            center.add(newNotificationRequest, withCompletionHandler: nil)
            return false
        }
    }
    
    func saveToFile(_ silent: Bool) {
        try! appDataPath.createFile(named: "settings.json", contents: """
            {
            "name": "\(player.name)",
            "level": "\(player.level)",
            "progress": "\(player.patchNumber)",
            "health": "\(Double(player.health))"
            }
""")
        
        if !silent {
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
    
    func deleteSettings() {
        if (appDataPath.containsFile(named: "settings.json")) {
            do {
                try appDataPath.file(named: "settings.json").delete()
                let content = UNMutableNotificationContent()
                if appDataPath.containsFile(named: "settings_backup.json") {
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
                
                do {
                    try appDataPath.file(named: "settings_backup.json").rename(to: "settings.json")
                } catch {
                    
                }
            } catch {
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
                            
                        }
                    }
                    try! importPathDirectory.file(named: "settings.json").copy(to: self.appDataPath)
                    let _ = self.loadFromFile()
                    
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
    
    init(whichPlayer: Player) {
        player = whichPlayer
    }
    
}
