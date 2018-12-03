//
//  Termina.swift
//  Termina
//
//  Created by Marquis Kurt on 11/20/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

import Foundation
import SpriteKit
import UserNotifications

/**
 Special monster class for Termina
 */
class Termina: Monster {
    
    /**
     Private API key
     
     Use this to connect to services such as Tutoriel, Aperture TestFile, and Project Scotia
     */
    private let apikey = "2be7654ed74eb3670ac46cf3bffd7a2c354159ab"

    func insult() {}

    func speakBeforeFighting() {}
    
    /**
     Takes damage and heals if within a specific range
     */
    override func takeDamage(_ amount: Int) {
        if Int.random(in: 0...10) > 3 {
            super.takeDamage(amount)
        } else {
            if health >= maximumHealth / 2 {
                heal(Int.random(in: 5...7))
            }
        }
    }
    
    /**
     Sends a notification to the user, mocking them about pacifying the entity
     */
    func pacifyComment() {
        if TerminaUserDefaults.canSendNotifications {
            let content = UNMutableNotificationContent()
            content.title = "Do you think you're being clever?"
            content.body = "Befriending your foes won't save you."
            let uuid = UUID().uuidString
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.01, repeats: false)
            let newNotificationRequest = UNNotificationRequest(identifier: uuid, content: content, trigger: trigger)
            let center = UNUserNotificationCenter.current()
            center.add(newNotificationRequest, withCompletionHandler: nil)
        }
    }
    
    /**
     Alerts the user when attempting to set 'Termina' as the name in Hardcore Mode
     */
    func mockPlayerHardcore() {
        let alert = NSAlert()
        alert.alertStyle = NSAlert.Style.critical
        alert.messageText = "How about no?"
        alert.informativeText = "Do you honestly think you're being funny?"
        alert.addButton(withTitle: "Quit")
        alert.runModal()
    }
    
    /**
     Alerts the user when attempting to set 'Susie' as the name in Hardcore Mode, given a set of conditions
     */
    func targetSusie() {
        let alert = NSAlert()
        alert.alertStyle = NSAlert.Style.critical
        alert.messageText = "So that's how we're playing it?"
        alert.informativeText = "Let's not forget who's in charge here. I expect nothing less from you."
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
    
    /**
     Alerts the user when attempting to set 'Asriel' as the name in Hardcore Mode, given a set of conditions
     
     Because he's here, she'll try to find what it is he wanted her to see, anyway.
     */
    func targetAsriel() {
        let alert = NSAlert()
        alert.alertStyle = NSAlert.Style.critical
        alert.messageText = "So that's how we're playing it?"
        alert.informativeText = "Let's see what you're hiding, old friend."
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
    
    /**
     Initialize the Termina class.
     
     - Parameters:
         - terminaNode: Termina's node in an SKScene
         - terminaHud: Termina's hud in an SKScene
     */
    init(terminaNode: SKSpriteNode, terminaHud: HUD) {
        super.init(myName: "Termina", myLevel: 420, myNode: terminaNode, myHealth: 4200, pacifiable: "yes", thisHud: terminaHud)
    }
    
    /**
     Initialize the Termina class with a blank node and HUD.
     
     Use this class if you need to access Termina's functions without hooking her up to an SKScene.
     */
    init() {
        super.init(myName: "Termina", myLevel: 420, myNode: SKSpriteNode(), myHealth: 4200, pacifiable: "yes", thisHud: HUD())
    }

}
