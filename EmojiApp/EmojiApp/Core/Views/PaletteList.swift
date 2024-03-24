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
        NavigationStack {
            List {
                ForEach(store.palettes) { palette in
                    NavigationLink(value: palette) {
                        VStack(alignment: .leading) {
                            Text(palette.name)
                            Text(palette.emojis).lineLimit(1)
                        }
                    }
                }
                .onDelete { indexSet in
                    withAnimation {
                        store.palettes.remove(atOffsets: indexSet)
                    }
                }
            }
            .navigationDestination(for: Palette.self) { palette in
                PaletteView(palette: palette)
            }
            .navigationTitle("\(store.name) Palettes")
        }
    }
}

#Preview {
    PaletteList()
}
