//
//  BetaProgramPane.swift
//  Termina
//
//  Created by Marquis Kurt on 12/3/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

import Cocoa

class BetaProgramPane: PreferencesViewController {

    @IBOutlet weak var sendAnalytics: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        if TerminaUserDefaults.sendBetaAnalytics {
            sendAnalytics.state = .on
        } else {
            sendAnalytics.state = .off
        }
    }
    
    override func viewDidDisappear() {
        if sendAnalytics.state == .on {
            TerminaUserDefaults().setBetaAnalytics(status: true)
        } else {
            TerminaUserDefaults().setBetaAnalytics(status: false)
        }
    }
    
}
