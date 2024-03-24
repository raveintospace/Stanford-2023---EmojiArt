//
//  PaletteEditor.swift
//  EmojiApp
//
//  Created by Uri on 24/3/24.
//

import SwiftUI

struct PaletteEditor: View {
    
    @Binding var palette: Palette
    
    private let emojiFont: Font = Font.system(size: 40)
    
    var body: some View {
        Form {
            Section(header: Text("Name")) {
                TextField("Name", text: $palette.name)
            }
            Section(header: Text("Emojis")) {
                Text("Add Emojis Here")
                    .font(emojiFont)
                removeEmojis
            }
        }
    }
}

//#Preview {
//    PaletteEditor()
//}

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
        .font(emojiFont)
    }
}
