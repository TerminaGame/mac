//
//  HardcoreModeView.swift
//  Termina
//
//  Created by Marquis Kurt on 11/30/19.
//  Copyright © 2019 Marquis Kurt. All rights reserved.
//

import SwiftUI

struct TerminaHardcoreModeView: View {
    
    @State private var name: String = ""
    private var parentController: NSViewController
    
    public init(parentController: NSViewController) {
        self.parentController = parentController
    }
    
    func cancel() {
        for child in parentController.children {
            child.dismiss(self)
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Go Hardcore")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .padding()
            Text("""
                Hardcore Mode is similar to the traditional game, but much more difficult. Once you die, the game will exit and your player settings will not be saved.

                If you wish to continue, enter your player name or use your existing player (we'll make a backup for you).
                """)
                .frame(maxWidth: .infinity, maxHeight: 96)
                .padding([.leading, .trailing])
            
            Spacer()
            
            VStack {
            
                TextField("Name", text: $name).padding()
                
                HStack {
                    Button(action: {
                        self.cancel()
                    }) {
                        Text("Cancel")
                    }
                    Spacer()
                    Button(action: {}) {
                        Text("Use Existing")
                    }
                    Button(action: {}) {
                        Text("Start Hardcore Mode")
                    }
                }.padding()
            
            }
            
        }
    }
}

//#if DEBUG
//struct TerminaHardcoreModeView_Previews: PreviewProvider {
//    static var previews: some View {
//        TerminaHardcoreModeView()
//    }
//}
//#endif
