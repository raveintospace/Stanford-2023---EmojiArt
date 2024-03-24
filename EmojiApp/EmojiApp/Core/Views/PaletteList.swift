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
                .onMove { IndexSet, newOffset in
                    store.palettes.move(fromOffsets: IndexSet, toOffset: newOffset)
                }
            }
            .navigationDestination(for: Palette.self) { palette in
                PaletteView(palette: palette)
                
                // uncomment so list navigates to PaletteEditor instead of PaletteView
//                if let index = store.palettes.firstIndex(where: { $0.id == palette.id }) {
//                    PaletteEditor(palette: $store.palettes[index])
//                }
            }
            .navigationTitle("\(store.name) Palettes")
            .toolbar {
                Button {
                    store.insert(name: "", emojis: "")
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

#Preview {
    PaletteList()
}
