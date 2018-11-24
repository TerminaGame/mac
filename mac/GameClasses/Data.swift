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
            
            return true
        } else {
            let content = UNMutableNotificationContent()
            content.title = "Player Data Missing"
            content.body = "Termina couldn't locate your player data."
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
            content.title = "\(player.name)'s Data Saved"
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
    
    init(whichPlayer: Player) {
        player = whichPlayer
    }
    
}
