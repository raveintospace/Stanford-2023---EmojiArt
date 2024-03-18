//
//  EmojiArtDocument.swift
//  EmojiApp
//
//  Created by Uri on 17/3/24.
//

import SwiftUI

class EmojiArtDocument: ObservableObject {
    
    typealias Emoji = EmojiArt.Emoji
    
    // model
    @Published private var emojiArt = EmojiArt()
    
    init() {
        emojiArt.addEmoji("🍄", at: .init(x: -200, y: -150), size: 200)
        emojiArt.addEmoji("🦧", at: .init(x: 200, y: 150), size: 100)
    }
    
    var emojis: [Emoji] {
        emojiArt.emojis
    }
    
    var background: URL? {
        emojiArt.background
    }
    
    // MARK: - Intents
    func setBackground(_ url: URL?) {
        emojiArt.background = url
    }
    
    func addEmoji(_ emoji: String, at position: Emoji.Position, size: CGFloat) {
        emojiArt.addEmoji(emoji, at: position, size: Int(size))
    }
}

// MARK: - Functions used in our view
extension EmojiArt.Emoji {
    
    var font: Font {
        Font.system(size: CGFloat(size))
    }
}

extension EmojiArt.Emoji.Position {
    func `in`(_ geometry: GeometryProxy) -> CGPoint {   // `in` to use reserved keyword "in"
        let center = geometry.frame(in: .local).center  // .center is an extension of CGRect
        return CGPoint(x: center.x + CGFloat(x), y: center.y - CGFloat(y))  //  x & y defined in model's Position
    }
}
