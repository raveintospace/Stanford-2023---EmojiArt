//
//  PaletteEditor.swift
//  EmojiApp
//
//  Created by Uri on 24/3/24.
//

import SwiftUI

struct PaletteEditor: View {
    
    let palette: Palette
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(palette.name)
            Text("Add Emojis Here")
            removeEmojis
        }
    }
}

#Preview {
    PaletteEditor()
}

extension PaletteEditor {
    
    private var removeEmojis: some View {
        VStack(alignment: .trailing) {
            Text("Tap to Remove Emojis")
                .font(.caption)
                .foregroundStyle(Color.gray)
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 40))]) {
                ForEach(palette.emojis.uniqued.map(String.init), id: \.self) { emoji in
                    Text(emoji)
                }
            }
        }
    }
}
