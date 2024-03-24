//
//  PaletteManager.swift
//  EmojiApp
//  Manages all the palettes in all the stores
//  Created by Uri on 24/3/24.
//

import SwiftUI

struct PaletteManager: View {
    
    let stores: [PaletteStore]
    
    @State private var selectedStore: PaletteStore?
    
    var body: some View {
        NavigationSplitView {
            List(stores, selection: $selectedStore) { store in
                Text(store.name)
                    .tag(store)
            }
        } detail: {
            Text("Choose a store")
        }
    }
}
