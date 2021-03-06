//
//  BetaProgramPane.swift
//  Termina for macOS
//
//  Created by Marquis Kurt on 12/3/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

import Cocoa

class BetaProgramPane: PreferencesViewController {

//    @IBOutlet weak var sendAnalytics: NSButton!
    @IBOutlet weak var demoMode: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        if TerminaUserDefaults.demoMode {
            demoMode.state = .on
        } else {
            demoMode.state = .off
        }
        
    }
    
    override func viewDidDisappear() {
//        if sendAnalytics.state == .on {
//            TerminaUserDefaults().setBetaAnalytics(status: true)
//        } else {
//            TerminaUserDefaults().setBetaAnalytics(status: false)
//        }
        
        if demoMode.state == .on {
            TerminaUserDefaults().toggleDemoMode(status: true)
        } else {
            TerminaUserDefaults().toggleDemoMode(status: false)
        }
        
    }
    
}
