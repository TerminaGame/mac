//
//  BetaHandler.swift
//  Termina for macOS
//
//  Created by Marquis Kurt on 12/1/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

import Foundation

struct BetaHandler {
    
    /**
     Variable that detects 'beta' in CFBundleVersion
     */
    static var isBetaBuild: Bool {
        get {
            let betaString = Bundle.main.infoDictionary?["CFBundleVersion"]
            if (betaString as! String).range(of: "beta") != nil {
                return true
            } else {
                return false
            }
        }
    }
}
