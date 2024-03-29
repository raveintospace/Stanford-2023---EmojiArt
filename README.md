# Stanford-2023 - EmojiArt
App developed following Stanford University's course CS193p (Developing Applications for iOS using SwiftUI) - https://cs193p.sites.stanford.edu/2023

<div style="text-align:center;">
<img src="EmojiApp/EmojiApp/Assets.xcassets/AppIcon.appiconset/emojiIcon.png" alt="App icon" title="App icon" width="150" height="150">
</div>
With this app you can drag images from other apps (ie: Safari, Photos) and use them as the background of the app's canvas, where you can drop emojis available in the app as palettes.

## This app features 
- App scene as DocumentGroup instead of WindowGroup, to work with document management
- GeometryReader to set the center of the view as X: 0, Y: 0
- Transferable protocol to drag content & Drop it into other content
- Async load of the images dragged from other apps (a URL is passed and converted to a UIImage)
- Gestures to zoom, pan and fit contents of View
- Button to change palette of emojis or to open a ContextMenu
- ContextMenu to add, remove, edit, explore or select palettes of emojis
- Sheet to edit any palette of emojis
- Sheet to select multiple palettes of emojis from a list, this list utilizes a NavigationStack to present each emoji individually
- The canva is saved as a custom document (.emojiart UTType) automatically with several user intents
- NotificationCenter observes changes in palettes and updates all the open windows of the app
- Sturldata: Type that implements Transferable protocol by proxy to String, Url and Data
- MVVM for the whole app (EmojiArt: background image and view components)
- MVVM for emoji collections (Palette)
- Custom App Icon made with Canva

**Extensions**
- String, to add each unique character into an array of Strings
- String, to remove a character if it matches the parameter passed
- Character, to check if a character is an Emoji
- CGRect, to find its center
- CGSize (typealiased as CGOffset), to facilitate working with operators (+, +=)
- UserDefaults, to get and set palettes managed by the user
- UTType, to work with DocumentGroup and implement protocol ReferenceFileDocument

**Components**
- AnimatedactionButton: Button with its actions animated
- UndoButton: Button able to redo & undo user actions with undoManager
- PaletteManager: A NavigationSplitView to manage all the palettes of all the themes, needs to be uncommented to see how it works

## Color Reference

| Color             | Hex                                                                |
| ----------------- | ------------------------------------------------------------------ |
| Accent Color | ![#F79744](https://via.placeholder.com/10/f79744?text=+) #F79744 |

## License

[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](https://choosealicense.com/licenses/mit/) [MIT](https://choosealicense.com/licenses/mit/) 

## Screenshots
<div style="display: flex; flex-wrap: wrap; justify-content: space-around;">
    <img src="Screenshots/Simulator Screenshot - iPad Pro (12.9-inch) (6th generation) - 2024-03-29 at 16.34.19.png" alt="Home View" title="Home View" width="300">
    <img src="Screenshots/Simulator Screenshot - iPad Pro (12.9-inch) (6th generation) - 2024-03-29 at 16.39.44.png" alt="Canva View & Undo button" title="Canva View & Undo button" width="300">
    <img src="Screenshots/Simulator Screenshot - iPad Pro (12.9-inch) (6th generation) - 2024-03-29 at 16.40.03.png" alt="Canva View & Context Menu" title="Canva View & Context Menu" width="300">
    <img src="Screenshots/Simulator Screenshot - iPad Pro (12.9-inch) (6th generation) - 2024-03-29 at 16.40.14.png" alt="Select palette" title="Select palette" width="300">
</div> 
<div style="display: flex; flex-wrap: wrap; justify-content: space-around;">
    <img src="Screenshots/Simulator Screenshot - iPad Pro (12.9-inch) (6th generation) - 2024-03-29 at 16.40.23.png" alt="Explore palettes" title="Explore palettes" width="300">
    <img src="Screenshots/Simulator Screenshot - iPad Pro (12.9-inch) (6th generation) - 2024-03-29 at 16.45.30.png" alt="Edit palette" title="Edit palette" width="300">
    <img src="Screenshots/Simulator Screenshot - iPad Pro (12.9-inch) (6th generation) - 2024-03-29 at 16.49.07.png" alt="Split View with another app" title="Split View with another app" width="300">
    <img src="Screenshots/Simulator Screenshot - iPad Pro (12.9-inch) (6th generation) - 2024-03-29 at 17.21.38.png" alt="Two windows of EmojiArt" title="Two windows of EmojiArt" width="300">
</div> 
