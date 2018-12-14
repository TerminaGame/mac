//
//  BetaViewController.swift
//  Termina for macOS
//
//  Created by Marquis Kurt on 11/28/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

import Foundation
import Cocoa

class BetaViewController: NSViewController {
    
    @IBOutlet var aboutDocumentView: NSTextView!
    
    /**
     Dismisses the sheet
     */
    @IBAction func dismissSheet(_ sender: Any) {
        dismiss(sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rtfPath = Bundle.main.url(forResource: "Termina macOS Beta Program", withExtension: "rtf")
        let rtfPathString = try! NSAttributedString(url: rtfPath!, options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.rtf], documentAttributes: nil)
        aboutDocumentView.textStorage?.setAttributedString(rtfPathString)
        aboutDocumentView.textStorage?.foregroundColor = NSColor.white
        
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
}
