//
//  NotificationPane.swift
//  Termina for macOS
//
//  Created by Marquis Kurt on 12/3/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

import Cocoa

class NotificationPane: PreferencesViewController {
    
    @IBOutlet weak var dataNotificationStatus: NSButton!
    @IBOutlet weak var gameNotificationStatus: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        if TerminaUserDefaults.canSendGameNotifications {
            gameNotificationStatus.state = .on
        } else {
            gameNotificationStatus.state = .off
        }
        if TerminaUserDefaults.canSendDataNotifications {
            dataNotificationStatus.state = .on
        } else {
            dataNotificationStatus.state = .off
        }
    }
    
    override func viewWillDisappear() {
        if dataNotificationStatus.state == .on && dataNotificationStatus.state == .on {
            try! TerminaUserDefaults().setUserNotifications(status: "all")
        } else {
            if dataNotificationStatus.state == .on && gameNotificationStatus.state == .off {
                try! TerminaUserDefaults().setUserNotifications(status: "data")
            } else if gameNotificationStatus.state == .on && dataNotificationStatus.state == .off {
                try! TerminaUserDefaults().setUserNotifications(status: "game")
            } else {
                try! TerminaUserDefaults().setUserNotifications(status: "none")
            }
        }
    }
    
}
