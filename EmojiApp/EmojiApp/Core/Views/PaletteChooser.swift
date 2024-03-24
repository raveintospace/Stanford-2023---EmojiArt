//
//  PaletteChooser.swift
//  EmojiApp
//
//  Created by Uri on 23/3/24.
//

import SwiftUI

struct PaletteChooser: View {
    
    @EnvironmentObject var store: PaletteStore
    @State private var showPaletteEditor: Bool = false
    @State private var showPaletteList: Bool = false
    
    var body: some View {
        HStack {
            chooser
            view(for: store.palettes[store.cursorIndex])
        }
        .clipped()  // stay inside its bounds, don't appear on other views
        .sheet(isPresented: $showPaletteEditor) {
            PaletteEditor(palette: $store.palettes[store.cursorIndex])
                .font(nil)  // use default font instead of inherited from parent view
        }
        .sheet(isPresented: $showPaletteList) {
            PaletteList()
                .font(nil)
        }
    }
}

#Preview {
    PaletteChooser()
        .environmentObject(PaletteStore(named: "Preview"))
}

extension PaletteChooser {
    
    private var chooser: some View {
        AnimatedActionButton(systemImage: "paintpalette") {
            store.cursorIndex += 1
        }
        .contextMenu {      // press & hold to activate
            selectPaletteMenu
            AnimatedActionButton("New Palette", systemImage: "plus") {
                store.insert(name: "", emojis: "")
                showPaletteEditor = true
            }
            AnimatedActionButton("Remove Palette", systemImage: "minus.circle", role: .destructive) {
                store.palettes.remove(at: store.cursorIndex)
            }
            AnimatedActionButton("Edit Palette", systemImage: "pencil") {
                showPaletteEditor = true
            }
            AnimatedActionButton("Explore Palettes", systemImage: "doc.text.magnifyingglass") {
                showPaletteList = true
            }
        }
    }
    
    // straight selection of palette
    private var selectPaletteMenu: some View {
        Menu {
            ForEach(store.palettes) { palette in
                AnimatedActionButton(palette.name) {
                    if let index = store.palettes.firstIndex(where: { $0.id == palette.id }) {
                        store.cursorIndex = index
                    }
                }
            }
        } label: {
            Label("Select Palette", systemImage: "text.insert")
        }
    }
    
    private func view(for palette: Palette) -> some View {
        HStack {
            Text(palette.name)
            ScrollingEmojis(palette.emojis)
        }
        .id(palette.id) // remove the HStack and present a new one for animation purposes
        .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .top)))
    }
}
