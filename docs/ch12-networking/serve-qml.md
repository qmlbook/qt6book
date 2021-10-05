# Serving UI via HTTP

To load a simple user interface via HTTP we need to have a web-server, which serves the UI documents. We start off with our own simple web-server using a python one-liner. But first, we need to have our demo user interface. For this, we create a small `Remote.qml` file in our project folder and create a red rectangle inside.

```qml
// remote.qml
import QtQuick

Rectangle {
    width: 320
    height: 320
    color: '#ff0000'
}
```

To serve this file we can start a small python script:

```sh
cd <PROJECT>
python -m http.server 8080
```

Now our file should be reachable via `http://localhost:8080/Remote.qml`. You can test it with:

```sh
curl http://localhost:8080/Remote.qml
```

Or just point your browser to the location. Your browser does not understand QML and will not be able to render the document through. 

Hopefully, Qt 6 provides such a browser in the form of the `qml` binary. You can directly load a remote QML document by using the following command:

```sh
qml -f http://localhost:8080/Remote.qml
```

Sweet and simple.

::: tip
If the `qml` program is not in your path, you can find it in the Qt binaries: `<qt-install-path>/<qt-version>/<your-os>/bin/qml`.
:::

Another way of importing a remote QML document is to dynamically load it using QML ! For this, we use a `Loader` element to retrieve for us the remote document.

```qml
// main.qml
import QtQuick

Loader {
    id: root
    source: 'http://localhost:8080/Remote.qml'
    onLoaded: {
        root.width = item.width
        root.height = item.height
    }
}
```

Now we can ask the `qml` executable to load the local `main.qml` loader document.

```sh
qml -f main.qml
```

::: tip
If you do not want to run a local server you can also use the gist service from GitHub. The gist is a clipboard like online services like Pastebin and others. It is available under [https://gist.github.com](https://gist.github.com). I created for this example a small gist under the URL [https://gist.github.com/jryannel/7983492](https://gist.github.com/jryannel/7983492). This will reveal a green rectangle. As the gist URL will provide the website as HTML code we need to attach a `/raw` to the URL to retrieve the raw file and not the HTML code.
:::

```qml
// remote.qml
import QtQuick

Loader {
    id: root
    source: 'https://gist.github.com/jryannel/7983492/raw'
    onLoaded: {
        root.width = item.width
        root.height = item.height
    }
}
```

To load another file over the network from `Remote.qml`, you will need to create a dedicated `qmldir` file in the same directory on the server. Once done, you will be able to reference the component by its name. 

## Networked Components

Let us create a small experiment. We add to our remote side a small button as a reusable component. 

Here's the directory structure that we will use:

```sh
./src/main.qml
./src/remote/qmldir
./src/remote/Button.qml
./src/remote/Remote.qml
```

Our `main.qml` is the same as in our previous example:

```qml
import QtQuick

Loader {
    id: root
    anchors.fill: parent
    source: 'http://localhost:8080/Remote.qml'
    onLoaded: {
        root.width = item.width
        root.height = item.height
    }
}
```

In the `remote` directory, we will update the `Remote.qml` file so that it uses a custom `Button` component coming from our own remote `Button.qml` file:

```qml
import QtQuick

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

Using a `qmldir`, we will define the content of our (remote) QML directory:

```qmldir
Button 1.0 Button.qml
```

And finally we will create our dummy `Button.qml` file:

```qml
import QtQuick.Controls

Button {
    
}
```

We can now launch our web-server (keep in mind that we now have a `remote` subdirectory):

```sh
cd src
python -m http.server --directory ./remote 8080
```

And remote QML loader:

```sh
qml -f main.qml
```

## Importing a QML components directory

By defining a `qmldir` file, it's also possible to directly import a library of components from a remote repository. To do so, a classical import works:

```js
import QtQuick
import "http://localhost:8080" as Remote

Rectangle {
    width: 320
    height: 320
    color: 'blue'

    Remote.Button {
        anchors.centerIn: parent
        text: 'Quit'
        onClicked: Qt.quit()
    }
}
```

::: tip
When using components from a local file system, they are created immediately without a latency. When components are loaded via the network they are created asynchronously. This has the effect that the time of creation is unknown and an element may not yet be fully loaded when others are already completed. Take this into account when working with components loaded over the network.
:::

