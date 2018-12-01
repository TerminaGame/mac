//
//  AboutViewController.swift
//  Termina
//
//  Created by Marquis Kurt on 11/24/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

import Foundation
import Cocoa

class AboutViewController: NSViewController {
    
    @IBOutlet weak var versionLabel: NSTextField!
    @IBOutlet var aboutDocumentView: NSTextView!
    @IBOutlet weak var betaButton: NSButton!
    @IBOutlet weak var aboutLogo: NSImageView!
    
    /**
     Dismisses the sheet
     */
    @IBAction func dismissView(_ sender: Any) {
        dismiss(sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        versionLabel.stringValue = "Version \(Bundle.main.infoDictionary?["CFBundleShortVersionString"] ?? "0.0.0") Build \(Bundle.main.infoDictionary?["CFBundleVersion"] ?? "0")"
        let rtfPath = Bundle.main.url(forResource: "About", withExtension: "rtf")
        let rtfPathString = try! NSAttributedString(url: rtfPath!, options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.rtf], documentAttributes: nil)
        aboutDocumentView.textStorage?.setAttributedString(rtfPathString)
        aboutDocumentView.textStorage?.foregroundColor = NSColor.white
        
        if !(BetaHandler.isBetaBuild) {
            betaButton.isHidden = true
        } else {
            aboutLogo.image = NSImage(imageLiteralResourceName: "LogoBeta")
        }
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
}
