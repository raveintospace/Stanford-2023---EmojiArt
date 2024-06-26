//
//  PaletteStore.swift
//  EmojiApp
//  Stores & persists palettes, it's its primary function
//  Created by Uri on 23/3/24.
//

import SwiftUI

final class PaletteStore: ObservableObject, Identifiable {
    
    let name: String
    
    // identifies each PaletteStore
    var id: String { name }
    
    private var userDefaultsKey: String { "PaletteStore:" + name }
    
    var palettes: [Palette] {
        get {
            UserDefaults.standard.palettes(forKey: userDefaultsKey)
        }
        set {
            if !newValue.isEmpty {
                UserDefaults.standard.set(newValue, forKey: userDefaultsKey)
                objectWillChange.send()
            }
        }
    }
    
    init(named name: String) {
        self.name = name
        
        if palettes.isEmpty {           // when there's no palette in UserDefaults
            palettes = Palette.builtins
            if palettes.isEmpty {
                palettes = [Palette(name: "Warning", emojis: "⚠️")]
            }
        }
        
        // update all the windows of the app when palettes are updated in any of them
        observer = NotificationCenter.default.addObserver(
            forName: UserDefaults.didChangeNotification,
            object: nil,
            queue: .main) { [weak self] notification in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.objectWillChange.send()
                }
            }
    }
    
    @State private var observer: NSObjectProtocol?
    
    // deinits the observer when app windows are closed
    deinit {
        if let observer {
            NotificationCenter.default.removeObserver(observer)
        }
    }
    
    // updates the index when clicking on the view's button, shows palette at index
    @Published private var _cursorIndex = 0
    
    var cursorIndex: Int {
        get { boundsCheckedPaletteIndex(_cursorIndex) }
        set { _cursorIndex = boundsCheckedPaletteIndex(newValue) }
    }
    
    private func boundsCheckedPaletteIndex(_ index: Int) -> Int {
        var index = index % palettes.count
        debugPrint("Index is \(index)")
        if index < 0 {
            index += palettes.count
        }
        return index
    }
    
    // MARK: - Adding Palettes
        
        // these functions are the recommended way to add Palettes to the PaletteStore
        // since they try to avoid duplication of Identifiable-ly identical Palettes
        // by first removing/replacing any Palette with the same id that is already in palettes
        // it does not "remedy" existing duplication, it just does not "cause" new duplication
        
        func insert(_ palette: Palette, at insertionIndex: Int? = nil) { // "at" default is cursorIndex
            let insertionIndex = boundsCheckedPaletteIndex(insertionIndex ?? cursorIndex)
            if let index = palettes.firstIndex(where: { $0.id == palette.id }) {
                palettes.move(fromOffsets: IndexSet([index]), toOffset: insertionIndex)
                palettes.replaceSubrange(insertionIndex...insertionIndex, with: [palette])
            } else {
                palettes.insert(palette, at: insertionIndex)
            }
        }
        
        func insert(name: String, emojis: String, at index: Int? = nil) {
            insert(Palette(name: name, emojis: emojis), at: index)
        }
        
        func append(_ palette: Palette) { // at end of palettes
            if let index = palettes.firstIndex(where: { $0.id == palette.id }) {
                if palettes.count == 1 {
                    palettes = [palette]
                } else {
                    palettes.remove(at: index)
                    palettes.append(palette)
                }
            } else {
                palettes.append(palette)
            }
        }
        
        func append(name: String, emojis: String) {
            append(Palette(name: name, emojis: emojis))
        }
}
