# Serving UI via HTTP

To load a simple user interface via HTTP we need to have a web-server, which serves the UI documents. We start off with our own simple web-server using a python one-liner. But first, we need to have our demo user interface. For this, we create a small `RemoteComponent.qml` file in our project folder and create a red rectangle inside.

<<< @/docs/ch13-networking/src/serve-qml-basics/RemoteComponent.qml#global

To serve this file we can start a small python script:

```sh
cd <PROJECT>
python -m http.server 8080
```

Now our file should be reachable via `http://localhost:8080/RemoteComponent.qml`. You can test it with:

```sh
curl http://localhost:8080/RemoteComponent.qml
```

Or just point your browser to the location. Unfortunately, your browser does not understand QML and will not be able to render the document. Fortunately, a QML web browser does exist. It's called [Canonic](https://www.canonic.com). Canonic is itself built with QML and runs in your web browser via WebAssembly. However, if you are using the WebAssembly version of Canonic, you won't be able to view files served from `localhost`; in a bit, you'll see how to make your QML files available to use with the WebAssembly version of Canonic. If you want, you can download the code to run Canonic as an app on your desktop, but there are security concerns related to doing so (see [here](https://docs.page/canonic/canonic) and [here](https://doc.qt.io/qt-6/qtqml-documents-networktransparency.html#implications-for-application-security) for more details).

Furthermore, Qt 6 provides the `qml` binary, which can be used like a web browser. You can directly load a remote QML document by using the following command:

```sh
qml http://localhost:8080/RemoteComponent.qml
```

Sweet and simple.

::: tip
If the `qml` program is not in your path, you can find it in the Qt binaries: `<qt-install-path>/<qt-version>/<your-os>/bin/qml`.
:::

Another way of importing a remote QML document is to dynamically load it using QML ! For this, we use a `Loader` element to retrieve for us the remote document.

<<< @/docs/ch13-networking/src/serve-qml-basics/LocalHostExample.qml#global

Now we can ask the `qml` executable to load the local `LocalHostExample.qml` loader document.

```sh
qml LocalHostExample.qml
```

::: tip
If you do not want to run a local server you can also use the gist service from GitHub. The gist is a clipboard like online services like Pastebin and others. It is available under [https://gist.github.com](https://gist.github.com). For this example, I created a small gist under the URL [https://gist.github.com/jryannel/7983492](https://gist.github.com/jryannel/7983492). This will reveal a green rectangle. As the gist URL will provide the website as HTML code we need to attach a `/raw` to the URL to retrieve the raw file and not the HTML code.

Since this content is hosted on a web server with a public web address, you can now use the web-based version of Canonic to view it. To do so, simply point your web browser to [https://app.canonic.com/#http://gist.github.com/jryannel/7983492](https://app.canonic.com/#http://gist.github.com/jryannel/7983492). Of course, you'll need to change the part after the `#` to view your own files.
:::

<<< @/docs/ch13-networking/src/serve-qml-basics/GistExample.qml#global

To load another file over the network from `RemoteComponent.qml`, you will need to create a dedicated `qmldir` file in the same directory on the server. Once done, you will be able to reference the component by its name. 

## Networked Components

Let us create a small experiment. We add to our remote side a small button as a reusable component. 

Here's the directory structure that we will use:

```sh
./src/SimpleExample.qml
./src/remote/qmldir
./src/remote/Button.qml
./src/remote/RemoteComponent.qml
```

Our `SimpleExample.qml` is the same as our previous `main.qml` example:

<<< @/docs/ch13-networking/src/serve-qml-networked-components/SimpleExample.qml#global

In the `remote` directory, we will update the `RemoteComponent.qml` file so that it uses a custom `Button` component:

<<< @/docs/ch13-networking/src/serve-qml-networked-components/remote/RemoteComponent.qml#global

As our components are hosted remotely, the QML engine needs to know what other components are available remotely. To do so, we define the content of our remote directory within a `qmldir` file:

<<< @/docs/ch13-networking/src/serve-qml-networked-components/remote/qmldir

And finally we will create our dummy `Button.qml` file:

<<< @/docs/ch13-networking/src/serve-qml-networked-components/remote/Button.qml#global

We can now launch our web-server (keep in mind that we now have a `remote` subdirectory):

```sh
cd src/serve-qml-networked-components/
python -m http.server --directory ./remote 8080
```

And remote QML loader:

```sh
qml SimpleExample.qml
```

## Importing a QML components directory

By defining a `qmldir` file, it's also possible to directly import a library of components from a remote repository. To do so, a classical import works:

<<< @/docs/ch13-networking/src/serve-qml-networked-components/LibraryExample.qml#global

::: tip
When using components from a local file system, they are created immediately without a latency. When components are loaded via the network they are created asynchronously. This has the effect that the time of creation is unknown and an element may not yet be fully loaded when others are already completed. Take this into account when working with components loaded over the network.
:::

::: warning
Be very cautious about loading QML components from the Internet. By doing so, you introduce the risk of accidentally downloading malicious components that will do evil things to your computer. These security risks have been [documented](https://doc.qt.io/qt-6/qtqml-documents-networktransparency.html#implications-for-application-security) by Qt. The Qt page was already linked to on this page, but the warning is worth repeating.
:::
