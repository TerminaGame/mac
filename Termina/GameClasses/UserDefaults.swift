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
     User-set preference for Termina's notification sending
     */
    static var canSendNotifications = UserDefaults().bool(forKey: "canSendNotifications")
    
    /**
     Change the user-set preference for sending notifications to a new value
     
     - Parameters:
        - status: Boolean value that indicates whether notifications should be sent.
     */
    func setUserNotifications(status: Bool) {
        UserDefaults().set(status, forKey: "canSendNotifications")
    }
    
    /**
     Create the list of user defaults if it doesn't exist already.
     */
    func createUserDefaults(){
        if !(UserDefaults().exists(key: "canSendNotifications")) {
            setUserNotifications(status: true)
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
