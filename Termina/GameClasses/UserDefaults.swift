//
//  UserDefaults.swift
//  Termina
//
//  Created by Marquis Kurt on 12/3/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

import Foundation
import Cocoa

struct TerminaUserDefaults {
    
    /**
     User-set preference for Termina's notification sending (all)
     */
    static var canSendNotifications = UserDefaults().bool(forKey: "canSendNotifications")
    
    /**
     User-set preference for Termina sending data-related notifications
     */
    static var canSendDataNotifications = UserDefaults().bool(forKey: "canSendDataNotifications")
    
    /**
     User-set preference for Termina sending game-related notifications
     */
    static var canSendGameNotifications = UserDefaults().bool(forKey: "canSendGameNotifications")
    
    /**
     Beta program preference for sending analytics to AppCenter.
     */
    static var sendBetaAnalytics = UserDefaults().bool(forKey: "sendBetaAnalytics")
    
    /**
     Beta program preference for displaying node count and FPS
     */
    static var displayBetaInformation = UserDefaults().bool(forKey: "displayBetaInformation")
    
    /**
     Beta program preference for enabling demo/kiosk mode
     */
    static var demoMode = UserDefaults().bool(forKey: "demoMode")
    
    /**
     Preference for hiding name from HUD
     */
    static var shouldHideNamesOnHud = UserDefaults().bool(forKey: "shouldHideNamesOnHud")
    
    /**
     Preference for hiding number on HUD
     */
    static var shouldHideHealthNumberOnHud = UserDefaults().bool(forKey: "shouldHideHealthNumberOnHud")
    
    /**
     Preference for hiding the level badge on HUD
     */
    static var shouldHideLevelBadgeOnHud = UserDefaults().bool(forKey: "shouldHideLevelBadgeOnHud")
    
    /**
     Change the user-set preference for sending notifications to a new value
     
     - Parameters:
        - status: The specific type of notification preferences (none, game, data, all)
     */
    func setUserNotifications(status: String) throws {
        switch (status) {
        case "none":
            UserDefaults().set(false, forKey: "canSendNotifications")
            UserDefaults().set(false, forKey: "canSendGameNotifications")
            UserDefaults().set(false, forKey: "canSendDataNotifications")
            break
        case "game":
            UserDefaults().set(true, forKey: "canSendNotifications")
            UserDefaults().set(true, forKey: "canSendGameNotifications")
            UserDefaults().set(false, forKey: "canSendDataNotifications")
            break
        case "data":
            UserDefaults().set(true, forKey: "canSendNotifications")
            UserDefaults().set(false, forKey: "canSendGameNotifications")
            UserDefaults().set(true, forKey: "canSendDataNotifications")
            break
        case "all":
            UserDefaults().set(true, forKey: "canSendNotifications")
            UserDefaults().set(true, forKey: "canSendGameNotifications")
            UserDefaults().set(true, forKey: "canSendDataNotifications")
            break
        default:
            throw TerminaUserDefaultsError.invalid
        }
    }
    
    func setBetaAnalytics(status: Bool) {
        UserDefaults().set(status, forKey: "sendBetaAnalytics")
    }
    
    func setBetaDisplay(status: Bool) {
        UserDefaults().set(status, forKey: "displayBetaInformation")
    }
    
    func toggleDemoMode(status: Bool) {
        UserDefaults().set(status, forKey: "demoMode")
    }
    
    func hideElement(what: String) throws {
        switch (what) {
        case "names":
            UserDefaults().set(true, forKey: "shouldHideNamesOnHud")
            break
        case "numbers":
            UserDefaults().set(true, forKey: "shouldHideHealthNumberOnHud")
            break
        case "badges":
            UserDefaults().set(true, forKey: "shouldHideLevelBadgeOnHud")
            break
        default:
            throw TerminaUserDefaultsError.invalid
        }
    }
    
    func showElement(what: String) throws {
        switch (what) {
        case "names":
            UserDefaults().set(false, forKey: "shouldHideNamesOnHud")
            break
        case "numbers":
            UserDefaults().set(false, forKey: "shouldHideHealthNumberOnHud")
            break
        case "badges":
            UserDefaults().set(false, forKey: "shouldHideLevelBadgeOnHud")
            break
        default:
            throw TerminaUserDefaultsError.invalid
        }
    }
    
    /**
     Create the list of user defaults if it doesn't exist already.
     */
    func createUserDefaults(){
        // All keys that should be TRUE
        let allTrueKeys = ["canSendNotifications", "canSendGameNotifications", "canSendDataNotifications"]
        
        for key in allTrueKeys {
            if !(UserDefaults().exists(key: key)) {
                UserDefaults().set(true, forKey: key)
            }
        }
        
        // All keys that should be FALSE
        let allFalseKeys = ["shouldHideNamesOnHud", "shouldHideHealthNumberOnHud", "shouldHideLevelBadgeOnHud"]
        
        for key in allFalseKeys {
            if !(UserDefaults().exists(key: key)) {
                UserDefaults().set(false, forKey: key)
            }
        }
        
        // Beta-specific
        let betaKeys = ["sendBetaAnalytics", "displayBetaInformation"]
        for key in betaKeys {
            if !(UserDefaults().exists(key: key)) && BetaHandler.isBetaBuild {
                UserDefaults().set(true, forKey: key)
            }
        }
        
        if !(UserDefaults().exists(key: "demoMode")) && BetaHandler.isBetaBuild {
            UserDefaults().set(false, forKey: "demoMode")
        }
        
        if !(UserDefaults().exists(key: "acknowledgedPossibleJumpscare")) {
            let alert = NSAlert()
            alert.messageText = "Termina Jumpscare Notice"
            alert.informativeText = "Thanks for downloading Termina! There may be a random chance that Termina will jumpscare you when you open the app; we figured you should have the heads-up first."
            alert.addButton(withTitle: "OK")
            alert.runModal()
            UserDefaults().set(true, forKey: "acknowledgedPossibleJumpscare")
        }
        
    }
    
}

extension UserDefaults {
    
    /**
     Determine whether a key exists or not in User Defaults.
     
     - Parameters:
        - key: The key to test
    
     - Returns: Boolean value that indicates the key's existence
     
     - Author: Norman from StackOverflow (see [StackOverflow post](https://stackoverflow.com/questions/47581644/swift-how-to-check-if-userdefaults-exists-and-if-not-save-a-chosen-standard-val?rq=1))
     */
    func exists(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
}

enum TerminaUserDefaultsError : Error {
    case invalid
}
