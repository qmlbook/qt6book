# FileIO Implementation

The `FileIO` implementation is straightforward. Remember the API we want to create should look like this.

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

```cpp
void FileIO::read()
{
    if(m_source.isEmpty()) {
        return;
    }
    QFile file(m_source.toLocalFile());
    if(!file.exists()) {
        qWarning() << "Does not exits: " << m_source.toLocalFile();
        return;
    }
    if(file.open(QIODevice::ReadOnly)) {
        QTextStream stream(&file);
        m_text = stream.readAll();
        emit textChanged(m_text);
    }
}
```

When the text is changed it is necessary to inform others about the change using `emit textChanged(m_text)`. Otherwise, property binding will not work.

The write method does the same but opens the file in write mode and uses the stream to write the contents.

```cpp
void FileIO::write()
{
    if(m_source.isEmpty()) {
        return;
    }
    QFile file(m_source.toLocalFile());
    if(file.open(QIODevice::WriteOnly)) {
        QTextStream stream(&file);
        stream << m_text;
    }
}
```

Do not forget to call `make install` at the end. Otherwise, your plugin files will not be copied over to the qml folder and the qml engine will not be able to locate the module.

As the reading and writing are blocking you should only use this `FileIO` for small texts, otherwise, you will block the UI thread of Qt. Be warned!

