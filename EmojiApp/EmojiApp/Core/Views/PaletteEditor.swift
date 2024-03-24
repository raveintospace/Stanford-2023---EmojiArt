//
//  PaletteEditor.swift
//  EmojiApp
//
//  Created by Uri on 24/3/24.
//

import SwiftUI

enum Focused {
    case name
    case addEmojis
}

struct PaletteEditor: View {
    
    @Binding var palette: Palette
    
    @State private var emojisToAdd: String = ""
    
    @FocusState private var focused: Focused?
    
    private let emojiFont: Font = Font.system(size: 40)
    
    var body: some View {
        Form {
            Section(header: Text("Name")) {
                TextField("Name", text: $palette.name)
                    .focused($focused, equals: .name)
            }
            Section(header: Text("Emojis")) {
                TextField("Add Emojis Here", text: $emojisToAdd)
                    .focused($focused, equals: .addEmojis)
                    .font(emojiFont)
                    .onChange(of: emojisToAdd) { _, newValue in
                        palette.emojis = (newValue + palette.emojis)
                            .filter { $0.isEmoji }
                            .uniqued
                    }
                removeEmojis
            }
        }
        .onAppear {
            if palette.name.isEmpty {
                focused = .name
            } else {
                focused = .addEmojis
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
                        .onTapGesture {
                            withAnimation {
                                palette.emojis.remove(emoji.first!)
                                emojisToAdd.remove(emoji.first!)
                            }
                        }
                }
            }
        }
        .font(emojiFont)
    }
}
