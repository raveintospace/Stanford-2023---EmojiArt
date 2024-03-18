//
//  EmojiArt.swift
//  EmojiApp
//
//  Created by Uri on 17/3/24.
//

import Foundation

struct EmojiArt {
    var background: URL?
    private(set) var emojis = [Emoji]() // avoids adding emojis outside the model
    
    private var uniqueEmojiId = 0
    
    mutating func addEmoji(_ emoji: String, at position: Emoji.Position, size: Int) {
        uniqueEmojiId += 1
        emojis.append(Emoji(
            string: emoji,
            position: position,
            size: size,
            id: uniqueEmojiId))
    }
    
    struct Emoji: Identifiable {
        let string: String
        var position: Position
        var size: Int
        var id: Int
        
        struct Position {
            var x: Int
            var y: Int
            
            static let zero = Self(x: 0, y: 0)      // used in view for cleaner code
        }
    }
}
