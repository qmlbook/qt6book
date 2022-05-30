# FileIO Implementation

Remember the `FileIO` API we want to create should look like this.

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

We will leave out the properties, as they are simple setters and getters.

The read method opens a file in reading mode and reads the data using a text stream.

<<< @/docs/ch18-extensions/src/fileio/fileio.cpp#read

When the text is changed it is necessary to inform others about the change using `emit textChanged(m_text)`. Otherwise, property binding will not work.

The write method does the same but opens the file in write mode and uses the stream to write the contents of the `text` property.

<<< @/docs/ch18-extensions/src/fileio/fileio.cpp#read

To make the type visible to QML, we add the `QML_ELEMENT` macro just after the `Q_PROPERTY` lines. This tells Qt that the type should be made available to QML. If you want to provide a different name than the C++ class, you can use the `QML_NAMED_ELEMENT` macro.

::: tip
As the reading and writing are blocking function calls you should only use this `FileIO` for small texts, otherwise, you will block the UI thread of Qt. Be warned!
:::
