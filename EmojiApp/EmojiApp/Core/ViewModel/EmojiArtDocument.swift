//
//  EmojiArtDocument.swift
//  EmojiApp
//
//  Created by Uri on 17/3/24.
//

import SwiftUI
import UniformTypeIdentifiers

extension UTType {
    static let emojiart = UTType(exportedAs: "edu.stanford.cs193p.emojiart")
}

final class EmojiArtDocument: ReferenceFileDocument {
    
    func snapshot(contentType: UTType) throws -> Data {
        try emojiArt.json()
    }
    
    func fileWrapper(snapshot: Data, configuration: WriteConfiguration) throws -> FileWrapper {
        return FileWrapper(regularFileWithContents: snapshot)
    }
    
    static var readableContentTypes: [UTType] {
        [.emojiart]
    }
    
    required init(configuration: ReadConfiguration) throws {
        if let data = configuration.file.regularFileContents {
            emojiArt = try EmojiArt(json: data)
        } else {
            throw CocoaError(.fileReadCorruptFile)
        }
    }
    
    typealias Emoji = EmojiArt.Emoji
    
    // model
    @Published private var emojiArt = EmojiArt() {
        didSet {
            // when background changes
            if emojiArt.background != oldValue.background {
                Task {
                    await fetchBackgroundImage()
                }
            }
        }
    }
    
    init() {}
    
    var emojis: [Emoji] {
        emojiArt.emojis
    }
    
    var bbox: CGRect {
        var bbox = CGRect.zero
        for emoji in emojiArt.emojis {
            bbox = bbox.union(emoji.bbox)
        }
        if let backgroundSize = background.uiImage?.size {
            bbox = bbox.union(CGRect(center: .zero, size: backgroundSize))
        }
        return bbox
    }
    
//      Commented from lesson 14
//    var background: URL? {
//        emojiArt.background
//    }
    
    @Published var background: Background = .none
    
    // MARK: - Background image handling - Lesson 14
    
    @MainActor
    private func fetchBackgroundImage() async {
        if let url = emojiArt.background {
            background = .fetching(url)
            do {
                let image = try await fetchUIImage(from: url)
                // security check to load the most recent url, ie the user drops a 2nd image while the 1st is still loading
                if url == emojiArt.background {
                    background = .found(image)
                }
            } catch {
                background = .failed("Couldn't set background: \(error.localizedDescription)")
            }
        } else {
            background = .none
        }
    }
    
    private func fetchUIImage(from url: URL) async throws -> UIImage {
        let (data, _) = try await URLSession.shared.data(from: url)
        if let uiImage = UIImage(data: data) {
            return uiImage
        } else {
            throw FetchError.badImageData
        }
    }
    
    enum Background {
        case none
        case fetching(URL)
        case found(UIImage)
        case failed(String)
        
        // properties that return their associated data
        var uiImage: UIImage? {
            switch self {
            case .found(let uiImage): return uiImage
            default: return nil
            }
        }
        
        var urlBeingFetched: URL? {
            switch self {
            case .fetching(let url): return url
            default: return nil
            }
        }
        
        var isFetching: Bool { urlBeingFetched != nil }
        
        var failureReason: String? {
            switch self {
            case .failed(let reason): return reason
            default: return nil
            }
        }
    }
    
    enum FetchError: Error {
        case badImageData
    }
    
    // MARK: - Intents
    
    // save with ReferenceFileDocument logic
    private func undoablyPerform(_ action: String, with undoManager: UndoManager? = nil, doit: () -> Void) {
        let oldEmojiArt = emojiArt
        doit()
        undoManager?.registerUndo(withTarget: self) { myself in
            myself.undoablyPerform(action, with: undoManager) {
                myself.emojiArt = oldEmojiArt
            }
        }
        undoManager?.setActionName(action)
    }
    
    func setBackground(_ url: URL?, undoWith undoManager: UndoManager? = nil) {
        undoablyPerform("Set background", with: undoManager) {
            emojiArt.background = url
        }
    }
    
    func addEmoji(_ emoji: String, at position: Emoji.Position, size: CGFloat, undoWith undoManager: UndoManager? = nil) {
        undoablyPerform("Add \(emoji)", with: undoManager) {
            emojiArt.addEmoji(emoji, at: position, size: Int(size))
        }
    }
    
    func move(_ emoji: Emoji, by offset: CGOffset, undoWith undoManager: UndoManager? = nil) {
        undoablyPerform("Move \(emoji)", with: undoManager) {
            let existingPosition = emojiArt[emoji].position
            emojiArt[emoji].position = Emoji.Position(
                x: existingPosition.x + Int(offset.width),
                y: existingPosition.y - Int(offset.height)
            )
        }
    }
    
    func move(emojiWithId id: Emoji.ID, by offset: CGOffset, undoWith undoManager: UndoManager? = nil) {
        if let emoji = emojiArt[id] {
            move(emoji, by: offset, undoWith: undoManager)
        }
    }
    
    func resize(_ emoji: Emoji, by scale: CGFloat, undoWith undoManager: UndoManager? = nil) {
        undoablyPerform("Resize \(emoji)", with: undoManager) {
            emojiArt[emoji].size = Int(CGFloat(emojiArt[emoji].size) * scale)
        }
    }
    
    func resize(emojiWithId id: Emoji.ID, by scale: CGFloat, undoWith undoManager: UndoManager? = nil) {
        if let emoji = emojiArt[id] {
            resize(emoji, by: scale, undoWith: undoManager)
        }
    }
}

// MARK: - Functions used in our view
extension EmojiArt.Emoji {
    
    var font: Font {
        Font.system(size: CGFloat(size))
    }
    
    var bbox: CGRect {
        CGRect(
            center: position.in(nil),
            size: CGSize(width: CGFloat(size), height: CGFloat(size))
        )
    }
}

extension EmojiArt.Emoji.Position {
    func `in`(_ geometry: GeometryProxy?) -> CGPoint {   // `in` to use reserved keyword "in"
        let center = geometry?.frame(in: .local).center ?? .zero  // .center is an extension of CGRect
        return CGPoint(x: center.x + CGFloat(x), y: center.y - CGFloat(y))  //  x & y defined in model's Position
    }
}
