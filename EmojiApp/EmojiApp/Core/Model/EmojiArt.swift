//
//  EmojiArt.swift
//  EmojiApp
//
//  Created by Uri on 17/3/24.
//

import Foundation

struct EmojiArt: Codable {
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
    
    func json() throws -> Data {
        return try JSONEncoder().encode(self)
    }
    
    struct Emoji: Identifiable, Codable {
        let string: String
        var position: Position
        var size: Int
        var id: Int
        
        struct Position: Codable {
            var x: Int
            var y: Int
            
            static let zero = Self(x: 0, y: 0)      // used in view for cleaner code
        }
    }
}
