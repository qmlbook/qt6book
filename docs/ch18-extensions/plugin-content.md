# 插件内容

插件（plugin）是一种带有已定义接口的库，按需加载。这与普通库不同：库是在应用程序启动时链接并加载的。在 QML 的情形中，该接口称为 `QQmlExtensionPlugin`。其中有两个方法值得我们关注：`initializeEngine()` 和 `registerTypes()`。插件首次加载时会调用 `initializeEngine()`，它使我们可以访问引擎，从而把插件对象暴露给根上下文。在大多数情况下，你只会用到 `registerTypes()` 方法。它允许你在给定的 URL 下向引擎注册你的自定义 QML 类型。

让我们通过构建一个小型 `FileIO` 工具类来探索一下。它能让你从 QML 读写文本文件。第一轮迭代的模拟 QML 实现可能如下所示。

```qml
// FileIO.qml (good)
QtObject {
    function write(path, text) {};
    function read(path) { return "TEXT" }
}
```

这是一个纯 QML 实现的、可能的基于 C++ 的 QML API。我们用它来探索 API。可以看到，我们需要 `read` 和 `write` 两个函数。还可以看到，`write` 函数接受 `path` 和 `text`，而 `read` 函数接受 `path` 并返回 `text`。看起来 `path` 和 `text` 是公共参数，也许可以把它们提取为属性，让这个 API 在声明式（declarative）环境中更易用。

```qml
// FileIO.qml (better)
QtObject {
    property url source
    property string text
    function write() {} // open file and write text 
    function read() {} // read file and assign to text 
}
```

是的，这看起来更像一个 QML API 了。我们使用属性，让周围环境能够绑定到这些属性并对变化作出反应。

要在 C++ 中创建这个 API，我们需要创建一个如下所示的 Qt C++ 接口。

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

需要向 QML 引擎注册 `FileIO` 类型。我们希望在“org.example.io”模块下使用它

```qml
import org.example.io 1.0

FileIO {
}
```

一个插件可以在同一个模块下暴露多个类型，但不能从一个插件暴露多个模块。因此模块与插件之间是一对一的关系。这种关系由模块标识符表示。
