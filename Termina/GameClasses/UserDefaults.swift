//
//  UserDefaults.swift
//  Termina
//
//  Created by Marquis Kurt on 12/3/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

import Foundation

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
    
    /**
     Create the list of user defaults if it doesn't exist already.
     */
    func createUserDefaults(){
        let allKeys = ["canSendNotifications", "canSendGameNotifications", "canSendDataNotifications"]
        
        for key in allKeys {
            if !(UserDefaults().exists(key: key)) {
                UserDefaults().set(true, forKey: key)
            }
        }
        
        // Beta-specific
        let betaKeys = ["sendBetaAnalytics"]
        for key in betaKeys {
            if !(UserDefaults().exists(key: key)) && BetaHandler.isBetaBuild {
                UserDefaults().set(true, forKey: key)
            }
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
