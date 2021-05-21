# Locator

The locator is a central component inside Qt Creator. It allows developers to navigate fast to specific locations inside the source code or inside the help. To open the locator press `Ctrl+K`.

![](./assets/locator.png)

A pop-up is coming from the bottom left and shows a list of options. If you just search a file inside your project just hit the first letter from the file name. The locator also accepts wild-cards, so `\*main.qml` will also work. Otherwise, you can also prefix your search to search for the specific content type.

![](./assets/creator-locator.png)

Please try it out. For example to open the help for the QML element Rectangle open the locator and type `? rectangle`. While you type the locator will update the suggestions until you found the reference you are looking for.

