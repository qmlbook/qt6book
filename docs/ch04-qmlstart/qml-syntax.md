# QML Syntax

QML is a declarative language used to describe how objects relate to each other. QtQuick is a framework built on QML for building the user interface of your application. It breaks down the user interface into smaller elements, which can be combined into components. QtQuick describes the look and the behavior of these user interface elements. This user interface description can be enriched with JavaScript code to provide simple but also more complex logic. In this perspective, it follows the HTML-JavaScript pattern but QML and QtQuick are designed from the ground up to describe user interfaces, not text-documents.

In its simplest form, QtQuick lets you create a hierarchy of elements. Child elements inherit the coordinate system from the parent. An `x,y` coordinate is always relative to the parent.

::: tip
QtQuick builds on QML. The QML language only knows of elements, properties, signals and bindings. QtQuick is a framework built on QML. Using default properties, the hierarchy of QtQuick elements can be constructed in an elegant way.
:::

![](./assets/scene.png)

Let’s start with a simple example of a QML file to explain the different syntax.

<<< @/docs/ch04-qmlstart/src/concepts/RectangleExample.qml#global

* The `import` statement imports a module. An optional version in the form of `<major>.<minor>` can be added.
* Comments can be made using `//` for single line comments or `/* */` for multi-line comments. Just like in C/C++ and JavaScript
* Every QML file needs to have exactly one root element, like HTML
* An element is declared by its type followed by `{ }`
* Elements can have properties, they are in the form `name: value`
* Arbitrary elements inside a QML document can be accessed by using their `id` (an unquoted identifier)
* Elements can be nested, meaning a parent element can have child elements. The parent element can be accessed using the `parent` keyword

With the `import` statement you import a QML module by name. In Qt5 you had to specify a major and minor version (e.g. `2.15`), this is now optional in Qt6. For the book content we drop this optional version number as normally you automatically want to choose the newest version available from your selected Qt Kit.

::: tip
Often you want to access a particular element by id or a parent element using the `parent` keyword. So it’s good practice to name your root element “root” using `id: root`. Then you don’t have to think about how the root element is named in your QML document.
:::

::: tip
You can run the example using the Qt Quick runtime from the command line from your OS like this:

    $ $QTDIR/bin/qml RectangleExample.qml

Where you need to replace the `$QTDIR` to the path to your Qt installation. The `qml` executable initializes the Qt Quick runtime and interprets the provided QML file.

In Qt Creator, you can open the corresponding project file and run the document  `RectangleExample.qml`.
:::

## Properties

Elements are declared by using their element name but are defined by using their properties or by creating custom properties. A property is a simple key-value pair, e.g. `width: 100`, `text: 'Greetings'`, `color: '#FF0000'`. A property has a well-defined type and can have an initial value.

```qml
Text {
    // (1) identifier
    id: thisLabel

    // (2) set x- and y-position
    x: 24; y: 16

    // (3) bind height to 2 * width
    height: 2 * width

    // (4) custom property
    property int times: 24

    // (5) property alias
    property alias anotherTimes: thisLabel.times

    // (6) set text appended by value
    text: "Greetings " + times

    // (7) font is a grouped property
    font.family: "Ubuntu"
    font.pixelSize: 24

    // (8) KeyNavigation is an attached property
    KeyNavigation.tab: otherLabel

    // (9) signal handler for property changes
    onHeightChanged: console.log('height:', height)

    // focus is need to receive key events
    focus: true

    // change color based on focus value
    color: focus ? "red" : "black"
}
```

Let’s go through the different features of properties:


* **(1)** `id` is a very special property-like value, it is used to reference elements inside a QML file (called “document” in QML). The `id` is not a string type but rather an identifier and part of the QML syntax. An `id` needs to be unique inside a document and it can’t be reset to a different value, nor may it be queried. (It behaves much like a reference in the C++ world.)

* **(2)** A property can be set to a value, depending on its type. If no value is given for a property, an initial value will be chosen. You need to consult the documentation of the particular element for more information about the initial value of a property.

* **(3)** A property can depend on one or many other properties. This is called *binding*. A bound property is updated when its dependent properties change. It works like a contract, in this case, the `height` should always be two times the `width`.

* **(4)** Adding new properties to an element is done using the `property` qualifier followed by the type, the name and the optional initial value (`property <type> <name> : <value>`). If no initial value is given, a default initial value is chosen.

::: tip
You can also declare one property to be the default property using `default` keyword. If another element is created inside the element and not explicitly bound to a property, it is bound to the default property. For instance, This is used when you add child elements. The child elements are added automatically to the default property `children` of type list if they are visible elements.
:::

* **(5)** Another important way of declaring properties is using the `alias` keyword (`property alias <name>: <reference>`). The `alias` keyword allows us to forward a property of an object or an object itself from within the type to an outer scope. We will use this technique later when defining components to export the inner properties or element ids to the root level. A property alias does not need a type, it uses the type of the referenced property or object.

* **(6)** The `text` property depends on the custom property `times` of type int. The `int` based value is automatically converted to a `string` type. The expression itself is another example of binding and results in the text being updated every time the `times` property changes.


* **(7)** Some properties are grouped properties. This feature is used when a property is more structured and related properties should be grouped together. Another way of writing grouped properties is `font { family: "Ubuntu"; pixelSize: 24 }`.


* **(8)** Some properties belong to the element class itself. This is done for global settings elements which appear only once in the application (e.g. keyboard input). The writing is `<Element>.<property>: <value>`.


* **(9)** For every property, you can provide a signal handler. This handler is called after the property changes. For example, here we want to be notified whenever the height changes and use the built-in console to log a message to the system.

::: warning
An element id should only be used to reference elements inside your document (e.g. the current file). QML provides a mechanism called "dynamic scoping", where documents loaded later on overwrite the element IDs from documents loaded earlier. This makes it possible to reference element IDs from previously loaded documents if they have not yet been overwritten. It’s like creating global variables. Unfortunately, this frequently leads to really bad code in practice, where the program depends on the order of execution. Unfortunately, this can’t be turned off. Please only use this with care; or, even better, don’t use this mechanism at all. It’s better to export the element you want to provide to the outside world using properties on the root element of your document.
:::

## Scripting

QML and JavaScript (also known as ECMAScript) are best friends. In the *JavaScript* chapter we will go into more detail on this symbiosis. Currently, we just want to make you aware of this relationship.

<<< @/docs/ch04-qmlstart/src/concepts/ScriptingExample.qml#text

* **(1)** The text changed handler `onTextChanged` prints the current text every time the text changed due to the space bar being pressed. As we use a parameter injected by the signal, we need to use the function syntax here. It's also possible to use an arrow function (`(text) => {}`), but we feel `function(text) {}` is more readable.


* **(2)** When the text element receives the space key (because the user pressed the space bar on the keyboard) we call a JavaScript function `increment()`.


* **(3)** Definition of a JavaScript function in the form of `function <name>(<parameters>) { ... }`, which increments our counter `spacePresses`. Every time `spacePresses` is incremented, bound properties will also be updated.

## Binding

The difference between the QML `:` (binding) and the JavaScript `=` (assignment) is that the binding is a contract and keeps true over the lifetime of the binding, whereas the JavaScript assignment (`=`) is a one time value assignment.

The lifetime of a binding ends when a new binding is set on the property or even when a JavaScript value is assigned to the property. For example, a key handler setting the text property to an empty string would destroy our increment display:

<<< @/docs/ch04-qmlstart/src/concepts/ScriptingExample.qml#clear-binding{2}


After pressing escape, pressing the space bar will not update the display anymore, as the previous binding of the `text` property (*text: “Space pressed: ” + spacePresses + ” times”*) was destroyed.

When you have conflicting strategies to change a property as in this case (text updated by a change to a property increment via a binding and text cleared by a JavaScript assignment) then you can’t use bindings! You need to use assignment on both property change paths as the binding will be destroyed by the assignment (broken contract!).

