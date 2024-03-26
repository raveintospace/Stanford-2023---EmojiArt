//
//  EmojiAppApp.swift
//  EmojiApp
//
//  Created by Uri on 17/3/24.
//

import SwiftUI

@main
struct EmojiAppApp: App {
    
    @StateObject var defaultDocument = EmojiArtDocument()
    @StateObject var paletteStore = PaletteStore(named: "Main")
    @StateObject var paletteStore2 = PaletteStore(named: "Alternate")
    @StateObject var paletteStore3 = PaletteStore(named: "Special")
    
    var body: some Scene {
        WindowGroup {
            //PaletteManager(stores: [paletteStore, paletteStore2, paletteStore3])
            EmojiArtDocumentView(document: defaultDocument)
                .environmentObject(paletteStore)
        }
    }
}
