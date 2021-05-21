# Serving UI via HTTP

To load a simple user interface via HTTP we need to have a web-server, which serves the UI documents. We start off with our own simple web-server using a python one-liner. But first, we need to have our demo user interface. For this, we create a small `main.qml` file in our project folder and create a red rectangle inside.

```qml
// main.qml
import QtQuick 2.5

Rectangle {
    width: 320
    height: 320
    color: '#ff0000'
}
```

To serve this file we launch a small python script:

```sh
cd <PROJECT>
python -m SimpleHTTPServer 8080
```

Now our file should be reachable via `http://localhost:8080/main.qml`. You can test it with:

```sh
curl http://localhost:8080/main.qml
```

Or just point your browser to the location. Your browser does not understand QML and will not be able to render the document through. We need to create now such a browser for QML documents. To render the document we need to point our `qmlscene` to the location. Unfortunately the `qmlscene` is limited to local files only. We could overcome this limitation by writing our own `qmlscene` replacement or simple dynamically load it using QML. We choose the dynamic loading as it works just fine. For this, we use a loader element to retrieve for us the remote document.

```qml
// remote.qml
import QtQuick 2.5

Loader {
    id: root
    source: 'http://localhost:8080/main2.qml'
    onLoaded: {
        root.width = item.width
        root.height = item.height
    }
}
```

Now we can ask the `qmlscene` to load the local `remote.qml` loader document. There is one glitch still. The loader will resize to the size of the loaded item. And our `qmlscene` needs also to adapt to that size. This can be accomplished using the `--resize-to-root` option to the `qmlscene`,

```sh
qmlscene --resize-to-root remote.qml
```

Resize to root tells the qml scene to resize its window to the size of the root element. The remote is now loading the `main.qml` from our local server and resizes itself to the loaded user interface. Sweet and simple.

::: tip
If you do not want to run a local server you can also use the gist service from GitHub. The gist is a clipboard like online services like Pastebin and others. It is available under [https://gist.github.com](https://gist.github.com). I created for this example a small gist under the URL [https://gist.github.com/jryannel/7983492](https://gist.github.com/jryannel/7983492). This will reveal a green rectangle. As the gist URL will provide the website as HTML code we need to attach a `/raw` to the URL to retrieve the raw file and not the HTML code.

```qml
// remote.qml
import QtQuick 2.5

Loader {
    id: root
    source: 'https://gist.github.com/jryannel/7983492/raw'
    onLoaded: {
        root.width = item.width
        root.height = item.height
    }
}
```
:::

To load another file over the network you just need to reference the component name. For example a `Button.qml` can be accessed as normal, as long it is in the same remote folder.

## Networked Components

Let us create a small experiment. We add to our remote side a small button as a reusable component.

```sh
./src/main.qml
./src/Button.qml
```

We modify our `main.qml` to use the button and save it as `main2.qml`:

```qml
import QtQuick 2.5

Rectangle {
    width: 320
    height: 320
    color: '#ff0000'

    Button {
        anchors.centerIn: parent
        text: 'Click Me'
        onClicked: Qt.quit()
    }
}
```

And launch our web-server again

```sh
cd src
python -m SimpleHTTPServer 8080
```

And our remote loader loads the main QML via HTTP again

```sh
qmlscene --resize-to-root remote.qml
```

What we see is an error

```
http://localhost:8080/main2.qml:11:5: Button is not a type
```

So QML cannot resolve the button component when it is loaded remotely. If the code would be local `qmlscene src/main.qml` this would be no issue. Locally Qt can parse the directory and detect which components are available but remotely there is no “list-dir” function for HTTP. We can force QML to load the element using the import statement inside `main.qml`:

```js
import "http://localhost:8080" as Remote

...

Remote.Button { ... }
```

This will work then when the `qmlscene` is run again:

```sh
qmlscene --resize-to-root remote.qml
```

Here the full code:

```js
// main2.qml
import QtQuick 2.5
import "http://localhost:8080" 1.0 as Remote

Rectangle {
    width: 320
    height: 320
    color: '#ff0000'

    Remote.Button {
        anchors.centerIn: parent
        text: 'Click Me'
        onClicked: Qt.quit()
    }
}
```

A better option is to use the `qmldir` file on the server side to control the export.

```qml
// qmldir
Button 1.0 Button.qml
```

And then updating the `main.qml`:

```js
import "http://localhost:8080" 1.0 as Remote

...

Remote.Button { ... }
```

::: tip
When using components from a local file system, they are created immediately without a latency. When components are loaded via the network they are created asynchronously. This has the effect that the time of creation is unknown and an element may not yet be fully loaded when others are already completed. Take this into account when working with components loaded over the network.
:::

