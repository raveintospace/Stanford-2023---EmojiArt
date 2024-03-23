//
//  PaletteStore.swift
//  EmojiApp
//  Stores & persists palettes, it's its primary function
//  Created by Uri on 23/3/24.
//

import SwiftUI

class PaletteStore: ObservableObject {
    
    @Published var palettes: [Palette] {
        didSet {
            if palettes.isEmpty, !oldValue.isEmpty {
                palettes = oldValue                         // avoids to delete the last palette
            }
        }
    }
    
    let name: String
    
    init(named name: String) {
        self.name = name
        palettes = Palette.builtins
        
        if palettes.isEmpty {
            palettes = [Palette(name: "Warning", emojis: "⚠️")]
        }
    }
    
    @Published private var _cursorIndex = 0
    
    var cursorIndex: Int {
        get { boundsCheckedPaletteIndex(_cursorIndex) }
        set { _cursorIndex = boundsCheckedPaletteIndex(newValue) }
    }
    
    private func boundsCheckedPaletteIndex(_ index: Int) -> Int {
        var index = index % palettes.count
        if index < 0 {
            index += palettes.count
        }
        return index
    }
}
