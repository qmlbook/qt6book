# Components

A component is a reusable element. QML provides different ways to create components. Currently, we will look only at the simplest form - a file-based component. A file-based component is created by placing a QML element in a file and giving the file an element name (e.g. `Button.qml`). You can use the component like every other element from the Qt Quick module. In our case, you would use this in your code as `Button { ... }`.

For example, let’s create a rectangle containing a text component and a mouse area. This resembles a simple button and doesn’t need to be more complicated for our purposes.

<<< @/docs/ch04-qmlstart/src/components/InlinedComponentExample.qml#button

The UI will look similar to this. In the first image, the UI is in its initial state, and in the second image the button has been clicked.

![](./assets/button_waiting.png)

![](./assets/button_clicked.png)


Now our task is to extract the button UI into a reusable component. For this, we should think about a possible API for our button. You can do this by imagining how someone else should use your button. Here’s what I came up with:

```qml
// minimal API for a button
Button {
    text: "Click Me"
    onClicked: { /* do something */ }
}
```

I would like to set the text using a `text` property and to implement my own click handler. Also, I would expect the button to have a sensible initial size, which I can overwrite (e.g. with `width: 240` for example).

To achieve this we create a `Button.qml` file and copy our button UI inside. Additionally, we need to export the properties a user might want to change at the root level.

<<< @/docs/ch04-qmlstart/src/components/Button.qml#global

We have exported the text property and the clicked signal at the root level. Typically we name our root element root to make referencing it easier. We use the `alias` feature of QML, which is a way to export properties inside nested QML elements to the root level and make this available for the outside world. It is important to know that only the root level properties can be accessed from outside this file by other components.

To use our new `Button` element we can simply declare it in our file. So the earlier example will become a little bit simplified.

<<< @/docs/ch04-qmlstart/src/components/ReusableComponentExample.qml#reusability

Now you can use as many buttons as you like in your UI by just using `Button { ... }`. A real button could be more complex, e.g. providing feedback when clicked or showing a nicer decoration.

::: tip
If you want to, you could even go a step further and use an `Item` as a root element. This prevents users from changing the color of the button we designed, and provides us with more control over the exported API. The target should be to export a minimal API. Practically, this means we would need to replace the root `Rectangle` with an `Item` and make the rectangle a nested element in the root item.

```qml
Item {
    id: root
    width: 116; height: 26

    property alias text: label.text
    signal clicked

    Rectangle {
        anchors.fill parent
        color: "lightsteelblue"
        border.color: "slategrey"
    }
    ...
}
```
:::

With this technique, it is easy to create a whole series of reusable components.

