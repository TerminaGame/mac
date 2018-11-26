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

class Termina: Monster {

    private let apikey = "2be7654ed74eb3670ac46cf3bffd7a2c354159ab"

    func insult() {}

    func speakBeforeFighting() {}

    override func takeDamage(_ amount: Int) {
        if Int.random(in: 0...10) > 3 {
            super.takeDamage(amount)
        } else {
            if health >= maximumHealth / 2 {
                heal(Int.random(in: 5...7))
            }
        }
    }
    
    func pacifyComment() {
        let content = UNMutableNotificationContent()
        content.title = "Do you think you're bring clever?"
        content.body = "Befriending your foes won't save you."
        let uuid = UUID().uuidString
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.01, repeats: false)
        let newNotificationRequest = UNNotificationRequest(identifier: uuid, content: content, trigger: trigger)
        let center = UNUserNotificationCenter.current()
        center.add(newNotificationRequest, withCompletionHandler: nil)
    }
    
    func targetSusie() {
        let alert = NSAlert()
        alert.alertStyle = NSAlert.Style.critical
        alert.messageText = "So that's how we're playing it?"
        alert.informativeText = "Let's not forget who's in charge here. I expect nothing less from you."
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
    
    func targetAsriel() {
        let alert = NSAlert()
        alert.alertStyle = NSAlert.Style.critical
        alert.messageText = "So that's how we're playing it?"
        alert.informativeText = "Let's see what you're hiding, old friend."
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }

    init(terminaNode: SKSpriteNode, terminaHud: HUD) {
        super.init(myName: "Termina", myLevel: 420, myNode: terminaNode, myHealth: 4200, pacifiable: "yes", thisHud: terminaHud)
    }
    
    init() {
        super.init(myName: "Termina", myLevel: 420, myNode: SKSpriteNode(), myHealth: 4200, pacifiable: "yes", thisHud: HUD())
    }

}
