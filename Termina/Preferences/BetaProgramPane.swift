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
    @IBOutlet weak var displayBetaInfo: NSButton!
    @IBOutlet weak var demoMode: NSButton!
    
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
        
        if TerminaUserDefaults.displayBetaInformation {
            displayBetaInfo.state = .on
        } else {
            displayBetaInfo.state = .off
        }
        
        if TerminaUserDefaults.demoMode {
            demoMode.state = .on
        } else {
            demoMode.state = .off
        }
    }
    
    override func viewDidDisappear() {
        if sendAnalytics.state == .on {
            TerminaUserDefaults().setBetaAnalytics(status: true)
        } else {
            TerminaUserDefaults().setBetaAnalytics(status: false)
        }
        
        if displayBetaInfo.state == .on {
            TerminaUserDefaults().setBetaDisplay(status: true)
        } else {
            TerminaUserDefaults().setBetaDisplay(status: false)
        }
        
        if demoMode.state == .on {
            TerminaUserDefaults().toggleDemoMode(status: true)
        } else {
            TerminaUserDefaults().toggleDemoMode(status: false)
        }
    }
    
}
