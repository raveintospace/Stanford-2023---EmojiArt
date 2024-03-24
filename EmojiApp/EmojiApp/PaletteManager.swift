//
//  PaletteManager.swift
//  EmojiApp
//  Manages all the palettes in all the stores
//  Created by Uri on 24/3/24.
//

import SwiftUI

struct PaletteManager: View {
    
    let stores: [PaletteStore]
    
    var body: some View {
        NavigationSplitView {
            List(stores) { store in
                Text(store.name)
            }
        } detail: {
            Text("Choose a store")
        }
    }
}
