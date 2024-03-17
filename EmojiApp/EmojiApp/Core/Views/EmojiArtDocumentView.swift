//
//  EmojiArtDocumentView.swift
//  EmojiApp
//
//  Created by Uri on 17/3/24.
//

import SwiftUI

struct EmojiArtDocumentView: View {
    
    private let emojis = "👻🍎😃🤪☹️🤯🐶🐭🦁🐵🦆🐝🐢🐄🐖🌲🌴🌵🍄🌞🌎🔥🌈🌧️🌨️☁️⛄️⛳️🚗🚙🚓🚲🛺🏍️🚘✈️🛩️🚀🚁🏰🏠❤️💤⛵️"
    
    var body: some View {
        VStack {
            Color.yellow
            ScrollingEmojis(emojis)
        }
    }
}

#Preview {
    EmojiArtDocumentView()
}

struct ScrollingEmojis: View {
    
    let emojis: [String]
    
    // convert our string of emojis to an array of strings
    init(_ emojis: String) {
        self.emojis = emojis.uniqued.map { String($0) }
    }
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(emojis, id: \.self) { emoji in
                    Text(emoji)
                }
            }
        }
    }
}
