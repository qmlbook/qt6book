# FileIO 实现

记住，我们要创建的 `FileIO` API 应该如下所示。

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

属性部分我们略去不写，因为它们只是简单的设置器（setter）与获取器（getter）。

read 方法以读取模式打开文件，并使用文本流读取数据。

<<< @/docs/ch18-extensions/src/fileio/fileio.cpp#read

当文本发生变化时，必须使用 `emit textChanged(m_text)` 通知其他部分这一变化。否则属性绑定将无法工作。

write 方法与此类似，但以写入模式打开文件，并使用流写入 `text` 属性的内容。

<<< @/docs/ch18-extensions/src/fileio/fileio.cpp#read

为了让 QML 能看到这个类型，我们在 `Q_PROPERTY` 行之后添加 `QML_ELEMENT` 宏。这告诉 Qt 该类型应当对 QML 可用。如果你想提供一个与 C++ 类不同的名称，可以使用 `QML_NAMED_ELEMENT` 宏。

::: tip
由于读写都是阻塞式函数调用，你应当只将这个 `FileIO` 用于较短的文本，否则会阻塞 Qt 的 UI 线程。请务必当心！
:::
