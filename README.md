# Stanford-2023 - EmojiArt
App made following Stanford University's course CS193p (Developing Applications for iOS using SwiftUI) - https://cs193p.sites.stanford.edu/2023

⚠️⚠️ App in construction ⚠️⚠️

With this app you can drag images from other apps (ie: Safari, Photos) and use them as the background of the app's canvas, where you can drop emojis available in the app as palettes.

Features
- GeometryReader to set the center of the view as X: 0, Y: 0
- Transferable protocol to drag content & Drop it into other content
- Async load of the images dragged from other apps (a URL is passed and converted to a UIImage)
- Gestures to zoom, pan and fit contents of View
- Button to change palette of emojis or open a ContextMenu
- ContextMenu to add, remove, edit, explore or select palettes of emojis
- Sheet to edit any palette of emojis
- Sheet to select several palettes of emojis from a list, this list uses a NavigationStack that navigates up to presenting each emoji individually
- UndoButton to undo & redo actions in the canvas
- PaletteManager: A NavigationSplitView to manage all the palettes of all the themes, needs to be uncommented to see how it works
- The canva is saved as a custom document (.emojiart UTType) automatically with several user intents
- App scene as DocumentGroup instead of WindowGroup, to work with document management
- NotificationCenter observes changes in palettes and updates all the open windows of the app

Extensions
- String, to add each unique carachter into an array of Strings
- String, to remove a character if it matches the parameter passed
- Character, to check if a character is an Emoji
- CGRect, to find its center
- CGSize (typealiased as CGOffset), to work with operators (+, +=)
- Button, to animate its actions
- UserDefaults, to get and set palettes managed by the user
- UTType, to work with DocumentGroup and implement protocol ReferenceFileDocument

Sturldata: Type that implements Transferable protocol by proxy to String, Url and Data

MVVM for the whole app (EmojiArt: background image and view components)
MVVM for emoji collections (Palette)

Custom App Icon made with Canva
