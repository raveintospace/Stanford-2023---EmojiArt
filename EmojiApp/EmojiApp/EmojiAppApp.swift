//
//  EmojiAppApp.swift
//  EmojiApp
//
//  Created by Uri on 17/3/24.
//

import SwiftUI

@main
struct EmojiAppApp: App {
    
    /* Commented on lesson 15, work with WindowGroup
    @StateObject var defaultDocument = EmojiArtDocument()
    @StateObject var paletteStore2 = PaletteStore(named: "Alternate")
    @StateObject var paletteStore3 = PaletteStore(named: "Special")
    */
    
    var body: some Scene {
        DocumentGroup(newDocument: { EmojiArtDocument() }) { config in
            //PaletteManager(stores: [paletteStore, paletteStore2, paletteStore3])
            EmojiArtDocumentView(document: config.document)
        }
    }
}
