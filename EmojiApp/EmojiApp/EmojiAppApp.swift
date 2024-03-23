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
    
    var body: some Scene {
        WindowGroup {
            EmojiArtDocumentView(document: defaultDocument)
                .environmentObject(paletteStore)
        }
    }
}
