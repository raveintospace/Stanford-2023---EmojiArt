//
//  PaletteList.swift
//  EmojiApp
//
//  Created by Uri on 24/3/24.
//

import SwiftUI

struct PaletteList: View {
    
    @EnvironmentObject var store: PaletteStore
    
    var body: some View {
        List(store.palettes) { palette in
            Text(palette.name)
        }
    }
}

#Preview {
    PaletteList()
}
