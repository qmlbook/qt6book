# Plugin Content

A plugin is a library with a defined interface, which is loaded on demand. This differs from a library as a library is linked and loaded on startup of the application. In the QML case, the interface is called `QQmlExtensionPlugin`. There are two methods interesting for us `initializeEngine()` and `registerTypes()`. When the plugin is loaded first the `initializeEngine()` is called, which allows us to access the engine to expose plugin objects to the root context. In the majority, you will only use the `registerTypes()` method. This allows you to register your custom QML types with the engine on the provided URL.

Let us explore by building a small `FileIO` utility class. It would let you read and write text files from QML. A first iteration could look like this in a mocked QML implementation.

```qml
// FileIO.qml (good)
QtObject {
    function write(path, text) {};
    function read(path) { return "TEXT" }
}
```

This is a pure QML implementation of a possible C++ based QML API. We use this to explore the API. We see we need a `read` and a `write` function. We also see that the `write` function takes a `path` and a `text`, while the `read` function takes a `path` and returns a `text`. As it looks, `path` and `text` are common parameters and maybe we can extract them as properties to make the API easier to use in a declarative context.

```qml
// FileIO.qml (better)
QtObject {
    property url source
    property string text
    function write() {} // open file and write text 
    function read() {} // read file and assign to text 
}
```

Yes, this looks more like a QML API. We use properties to allow our environment to bind to our properties and react to changes.

To create this API in C++ we would need to create a Qt C++ interface looking like this.

```cpp
class FileIO : public QObject {
    ...
    Q_PROPERTY(QUrl source READ source WRITE setSource NOTIFY sourceChanged)
    Q_PROPERTY(QString text READ text WRITE setText NOTIFY textChanged)
    ...
public:
    Q_INVOKABLE void read();
    Q_INVOKABLE void write();
    ...
}
```

The `FileIO` type need to be registered with the QML engine. We want to use it under the “org.example.io” module

```qml
import org.example.io 1.0

FileIO {
}
```

A plugin could expose several types with the same module. But it can not expose several modules from one plugin. So there is a one to one relationship between modules and plugins. This relationship is expressed by the module identifier.
