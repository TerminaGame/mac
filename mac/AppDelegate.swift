//
//  AppDelegate.swift
//  mac
//
//  Created by Marquis Kurt on 11/18/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//


import Cocoa
import UserNotifications

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    static var dataModel = DataModel(whichPlayer: Player(name: "Frisk"))
    static var gotLoadedData = false
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        AppDelegate.gotLoadedData = AppDelegate.dataModel.loadFromFile()
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        AppDelegate.dataModel.saveToFile(false)
    }
    
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
    
}
