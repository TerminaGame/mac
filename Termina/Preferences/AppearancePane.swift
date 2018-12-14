//
//  AppearancePane.swift
//  Termina for macOS
//
//  Created by Marquis Kurt on 12/10/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

import Cocoa

class AppearancePane: PreferencesViewController {

    @IBOutlet weak var hideNames: NSButton!
    @IBOutlet weak var hideHealthInteger: NSButton!
    @IBOutlet weak var hideBadge: NSButton!
    @IBOutlet weak var displayBetaInfo: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        if TerminaUserDefaults.shouldHideNamesOnHud {
            hideNames.state = .on
        } else {
            hideNames.state = .off
        }
        
        if TerminaUserDefaults.shouldHideHealthNumberOnHud {
            hideHealthInteger.state = .on
        } else {
            hideHealthInteger.state = .off
        }
        
        if TerminaUserDefaults.shouldHideLevelBadgeOnHud {
            hideBadge.state = .on
        } else {
            hideBadge.state = .off
        }
        
        if TerminaUserDefaults.displayBetaInformation {
            displayBetaInfo.state = .on
        } else {
            displayBetaInfo.state = .off
        }
        
    }
    
    
    override func viewWillDisappear() {
        if hideNames.state == .on {
            try! TerminaUserDefaults().hideElement(what: "names")
        } else {
            try! TerminaUserDefaults().showElement(what: "names")
        }
        
        if hideHealthInteger.state == .on {
            try! TerminaUserDefaults().hideElement(what: "numbers")
        } else {
            try! TerminaUserDefaults().showElement(what: "numbers")
        }
        
        if hideBadge.state == .on {
            try! TerminaUserDefaults().hideElement(what: "badges")
        } else {
            try! TerminaUserDefaults().showElement(what: "badges")
        }
        
        if displayBetaInfo.state == .on {
            TerminaUserDefaults().setBetaDisplay(status: true)
        } else {
            TerminaUserDefaults().setBetaDisplay(status: false)
        }
    }
    
}
