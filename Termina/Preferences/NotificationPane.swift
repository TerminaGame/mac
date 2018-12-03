//
//  NotificationPane.swift
//  Termina
//
//  Created by Marquis Kurt on 12/3/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

import Cocoa

class NotificationPane: PreferencesViewController {

    @IBOutlet weak var enableAllNotifications: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear() {
        enableAllNotifications.isEnabled = TerminaUserDefaults.canSendNotifications
    }
    
    override func viewWillDisappear() {
        let status = enableAllNotifications.isEnabled
        TerminaUserDefaults().setUserNotifications(status: status)
    }
    
}
