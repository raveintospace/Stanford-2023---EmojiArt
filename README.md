# Stanford-2023 - EmojiArt
Draw app made following Stanford University's course CS193p (Developing Applications for iOS using SwiftUI) - https://cs193p.sites.stanford.edu/2023

⚠️⚠️ App in construction ⚠️⚠️

With this app you can drag images from other apps (ie: Safari, Photos) and use them as the background of the app's canvas, where you can drop emojis available in the app.

Features
- GeometryReader to set the center of the view as X: 0, Y: 0
- Transferable (Drag content & Drop it into other content)
- Gestures to zoom and pan contents of View
- Button to choose palettes of emojis
- ContextMenu to add & remove palettes of emojis

Extensions
- CGRect, to find its center
- String, to add each unique carachter into an array of Strings
- CGSize (typealiased as CGOffset), to work with operators (+, +=)
- Button, to animate its actions

Sturldata: Type that implements Transferable by proxy to String, Url and Data

MVVM for the whole app (EmojiArt: background image and view components)
MVVM for emoji collections (Palette)
