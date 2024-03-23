//
//  PaletteChooser.swift
//  EmojiApp
//
//  Created by Uri on 23/3/24.
//

import SwiftUI

struct PaletteChooser: View {
    
    @ObservedObject var store: PaletteStore
    
    var body: some View {
        HStack {
            chooser
            view(for: store.palettes[store.cursorIndex])
        }
    }
}

#Preview {
    PaletteChooser(store: PaletteStore(named: "Sports"))
}

extension PaletteChooser {
    
    private var chooser: some View {
        Button {
            
        } label: {
            Image(systemName: "paintpalette")
        }
    }
    
    private func view(for palette: Palette) -> some View {
        HStack {
            Text(palette.name)
            ScrollingEmojis(palette.emojis)
        }
    }
}
