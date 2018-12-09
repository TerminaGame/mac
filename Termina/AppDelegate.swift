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
import AppCenter
import AppCenterAnalytics
import AppCenterCrashes

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, UNUserNotificationCenterDelegate {
    
    /**
     The data model which stores player information.
     */
    static var dataModel = DataModel(whichPlayer: Player(name: "Frisk"))
    static var gotLoadedData = false
    static var isHardcore = false
    @IBOutlet weak var resetMenuItem: NSMenuItem!
    @IBOutlet weak var deleteMenuItem: NSMenuItem!
    @IBOutlet weak var feedbackMenuItem: NSMenuItem!
    
    var preferencesController: NSWindowController?
    
    /**
     Opens the feedback website (if in a beta program)
     */
    @IBAction func openFeedback(_ sender: Any) {
        NSWorkspace.shared.open(URL(string: "https://github.com/TerminaGame/mac/issues/new?template=beta-report.md")!)
    }
    
    /**
     Opens the About pane.
     */
    @IBAction func getAboutSheet(_ sender: Any) {
        NSApplication.shared.mainWindow?.contentViewController?.presentAsSheet(NSStoryboard(name: "About", bundle: Bundle.main).instantiateController(withIdentifier: "About") as! NSViewController)
    }
    
    /**
     Opens the player profile page.
     */
    @IBAction func getPlayerInfo(_ sender: Any) {
        NSApplication.shared.mainWindow?.contentViewController?.presentAsSheet(NSStoryboard(name: "Profile", bundle: Bundle.main).instantiateController(withIdentifier: "Profile") as! NSViewController)
    }
    
    @IBAction func openPreferencesPane(_ sender: Any) {
        if !(preferencesController != nil) {
            
            let storyboard = NSStoryboard(name: "Preferences", bundle: nil)
            
            preferencesController = storyboard.instantiateInitialController() as? NSWindowController
            
        }
        
        if preferencesController != nil {
            preferencesController?.showWindow(sender)
        }
    }
    
    /**
     Tells the data model to use an NSOpenPanel to import settings.
     */
    @IBAction func importSettingsFIle(_ sender: Any) {
        AppDelegate.dataModel.importSettings()
    }
    
    /**
     Tells the data model to save the play profile.
     */
    @IBAction func saveDataFromMenu(_ sender: Any) {
        AppDelegate.dataModel.saveToFile(false)
    }
    
    /**
     Prompts the user to confirm a reset.
     */
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
    
    /**
     Prompts the user to confirm deleting their data.
     */
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
    
    /**
     Typical code to launch after the application finishes loading.
     */
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        // Create the user defaults.
        TerminaUserDefaults().createUserDefaults()
        
        // Connect to MS AppCenter for beta testing releases
        if BetaHandler.isBetaBuild {
            if TerminaUserDefaults.sendBetaAnalytics {
                MSAppCenter.start("dd5d5c2f-8d90-4f89-9c55-e81b02d36d8f", withServices:[
                    MSAnalytics.self,
                    MSCrashes.self
                    ])
            } else {
                MSAppCenter.start("dd5d5c2f-8d90-4f89-9c55-e81b02d36d8f", withServices:[
                    MSCrashes.self
                    ])
            }
            
            feedbackMenuItem!.isHidden = false
        }
        
        let center = UNUserNotificationCenter.current()
        // Request permission to display alerts and play sounds.
        center.requestAuthorization(options: [.alert, .sound])
        { (granted, error) in
            
        }
        
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
                AppDelegate.dataModel.restoreSettings()
                let _ = AppDelegate.dataModel.loadFromFile()
            }
        }
    }
    
    /**
     Typical code that executes upon receiving a request to terminate the application.
     */
    func applicationShouldTerminate(_ sender: NSApplication) -> NSApplication.TerminateReply {
        let temporaryLoad = DataModel(whichPlayer: Player(name: "Frisk"))
        let _ = temporaryLoad.loadFromFile()
        
        if AppDelegate.isHardcore {
            AppDelegate.dataModel.deleteSettings()
            AppDelegate.dataModel.restoreSettings()
            return NSApplication.TerminateReply.terminateNow
        } else if temporaryLoad.player.asArray() != AppDelegate.dataModel.player.asArray() {
            let alert = NSAlert()
            alert.messageText = "Are you sure you want to quit the game?"
            alert.informativeText = "Your data will automatically save before quitting. If you are in Hardcore Mode, your data will not be saved."
            
            alert.addButton(withTitle: "Quit")
            alert.addButton(withTitle: "Cancel")
            let response = alert.runModal().rawValue
            
            if response == 1000 {
                if AppDelegate.dataModel.appDataPath.containsFile(named: "settings.json") && !AppDelegate.isHardcore {
                    AppDelegate.dataModel.saveToFile(false)
                }
                return NSApplication.TerminateReply.terminateNow
            } else {
                return NSApplication.TerminateReply.terminateCancel
            }
        } else if !(AppDelegate.dataModel.appDataPath.containsFile(named: "settings.json")) {
            return NSApplication.TerminateReply.terminateNow
        } else {
            AppDelegate.dataModel.saveToFile(false)
            return NSApplication.TerminateReply.terminateNow
        }
    }
    
    /**
     Handler and operator for user notifications.
     */
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert])
    }
    
    func applicationWillTerminate(_ aNotification: Notification) { }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
    
}
