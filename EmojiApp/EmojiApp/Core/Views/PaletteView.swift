//
//  PaletteView.swift
//  EmojiApp
//
//  Created by Uri on 24/3/24.
//

import SwiftUI

struct PaletteView: View {
    
    let palette: Palette
    
    private let singleEmojiFont: Font = Font.system(size: 300)
    
    var body: some View {
        VStack {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 40))]) {
                ForEach(palette.emojis.uniqued.map(String.init), id: \.self) { emoji in
                    NavigationLink(value: emoji) {
                        Text(emoji)
                    }
                }
            }
            .navigationDestination(for: String.self) { emoji in
                Text(emoji)
                    .font(singleEmojiFont)
            }
            Spacer()
        }
        .padding()
        .font(.largeTitle)
        .navigationTitle(palette.name)
    }
}
