# Input Elements

We have already used the `MouseArea` as a mouse input element. Next, we’ll focus on keyboard input. We start off with the text editing elements: `TextInput` and `TextEdit`.

## TextInput

`TextInput` allows the user to enter a line of text. The element supports input constraints such as `validator`, `inputMask`, and `echoMode`.

```qml
// textinput.qml

import QtQuick

Rectangle {
    width: 200
    height: 80
    color: "linen"

    TextInput {
        id: input1
        x: 8; y: 8
        width: 96; height: 20
        focus: true
        text: "Text Input 1"
    }

    TextInput {
        id: input2
        x: 8; y: 36
        width: 96; height: 20
        text: "Text Input 2"
    }
}
```

![](./assets/textinput.png)


The user can click inside a `TextInput` to change the focus. To support switching the focus by keyboard, we can use the `KeyNavigation` attached property.

```qml
// textinput2.qml

import QtQuick

Rectangle {
    width: 200
    height: 80
    color: "linen"

    TextInput {
        id: input1
        x: 8; y: 8
        width: 96; height: 20
        focus: true
        text: "Text Input 1"
        KeyNavigation.tab: input2
    }

    TextInput {
        id: input2
        x: 8; y: 36
        width: 96; height: 20
        text: "Text Input 2"
        KeyNavigation.tab: input1
    }
}
```

The `KeyNavigation` attached property supports a preset of navigation keys where an element id is bound to switch focus on the given key press.

A text input element comes with no visual presentation beside a blinking cursor and the entered text. For the user to be able to recognize the element as an input element it needs some visual decoration; for example, a simple rectangle. When placing the `TextInput` inside an element you need make sure you export the major properties you want others to be able to access.

We move this piece of code into our own component called `TLineEditV1` for reuse.

```qml
// TLineEditV1.qml

import QtQuick

Rectangle {
    width: 96; height: input.height + 8
    color: "lightsteelblue"
    border.color: "gray"

    property alias text: input.text
    property alias input: input

    TextInput {
        id: input
        anchors.fill: parent
        anchors.margins: 4
        focus: true
    }
}
```

::: tip
If you want to export the `TextInput` completely, you can export the element by using `property alias input: input`. The first `input` is the property name, where the 2nd input is the element id.
:::

We then rewrite our `KeyNavigation` example with the new `TLineEditV1` component.

```qml
Rectangle {
    ...
    TLineEditV1 {
        id: input1
        ...
    }
    TLineEditV1 {
        id: input2
        ...
    }
}
```

![](./assets/textinput3.png)

Try the tab key for navigation. You will experience the focus does not change to `input2`. The simple use of `focus: true` is not sufficient. The problem is that when the focus was transferred to the `input2` element, the top-level item inside the `TlineEditV1` (our `Rectangle`) received focus, and did not forward the focus to the `TextInput`. To prevent this, QML offers the `FocusScope`.

## FocusScope

A focus scope declares that the last child element with `focus: true` receives the focus when the focus scope receives the focus. So it forwards the focus to the last focus-requesting child element. We will create a second version of our TLineEdit component called TLineEditV2, using a focus scope as the root element.

```qml
// TLineEditV2.qml

import QtQuick

FocusScope {
    width: 96; height: input.height + 8
    Rectangle {
        anchors.fill: parent
        color: "lightsteelblue"
        border.color: "gray"

    }

    property alias text: input.text
    property alias input: input

    TextInput {
        id: input
        anchors.fill: parent
        anchors.margins: 4
        focus: true
    }
}
```

Our example now looks like this:

```qml
Rectangle {
    ...
    TLineEditV2 {
        id: input1
        ...
    }
    TLineEditV2 {
        id: input2
        ...
    }
}
```

Pressing the tab key now successfully switches the focus between the 2 components and the correct child element inside the component is focused.

## TextEdit

The `TextEdit` is very similar to `TextInput`, and supports a multi-line text edit field. It doesn’t have the text constraint properties, as this depends on querying the content size of the text (`contentHeight`, `contentWidth`). We also create our own component called `TTextEdit` to provide an editing background and use the focus scope for better focus forwarding.

```qml
// TTextEdit.qml

import QtQuick

FocusScope {
    width: 96; height: 96
    Rectangle {
        anchors.fill: parent
        color: "lightsteelblue"
        border.color: "gray"

    }

    property alias text: input.text
    property alias input: input

    TextEdit {
        id: input
        anchors.fill: parent
        anchors.margins: 4
        focus: true
    }
}
```

You can use it like the `TLineEdit` component

```qml
// textedit.qml

import QtQuick

Rectangle {
    width: 136
    height: 120
    color: "linen"

    TTextEdit {
        id: input
        x: 8; y: 8
        width: 120; height: 104
        focus: true
        text: "Text Edit"
    }
}
```

![](./assets/textedit.png)

## Keys Element

The attached property `Keys` allows executing code based on certain key presses. For example, to move and scale a square, we can hook into the up, down, left and right keys to translate the element, and the plus and minus keys to scale the element.

<<< @/docs/ch04-qmlstart/src/input/KeysExample.qml#global

![](./assets/keys.png)

