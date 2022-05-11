# Local files

Is it also possible to load local (XML/JSON) files using the XMLHttpRequest. For example a local file named “colors.json” can be loaded using:

```js
xhr.open("GET", "colors.json")
```

We use this to read a color table and display it as a grid. It is not possible to modify the file from the Qt Quick side. To store data back to the source we would need a small REST based HTTP server or a native Qt Quick extension for file access.

<<< @/docs/ch13-networking/src/localfiles/localfiles.qml#global

:::tip
By default, using GET on a local file is disabled by the QML engine. To overcome this limitation, you can set the `QML_XHR_ALLOW_FILE_READ` environment variable to `1`:

```sh
QML_XHR_ALLOW_FILE_READ=1 qml localfiles.qml
```

The issue is when allowing a QML application to read local files through an `XMLHttpRequest`, hence `XHR`, this opens up the entire file system for reading, which is a potential security issue. Qt will allow you to read local files only if the environment variable is set, so that this is a concious decision.
:::

Instead of using the `XMLHttpRequest` it is also possible to use the XmlListModel to access local files.

<<< @/docs/ch13-networking/src/localfiles/localfilesxmlmodel.qml#global

With the XmlListModel it is only possible to read XML files and not JSON files.

