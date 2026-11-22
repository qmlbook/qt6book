# 设置（Settings）

Qt 提供了一个 `Settings` 元素用于加载和存储设置。该元素仍属于实验室（Labs）模块，这意味着其 API 未来可能会发生不兼容的变化。因此请留意。

下面是一个小示例，它把一个颜色值应用到基础矩形上。每当用户点击窗口时，都会生成一个新的随机颜色。当应用关闭并重新启动后，你应该能看到上一次使用的颜色。默认颜色应当是根矩形上最初设置的颜色。

<<< @/docs/ch14-storage/src/colorstore/colorstore.qml#M1

设置值会在每次发生变化时被存储。这未必总是你想要的。若只想在需要时存储设置，可以使用普通属性，并配合一个在调用时修改设置的函数。

```qml
Rectangle {
    id: root
    color: settings.color
    Settings {
        id: settings
        property color color: '#000000'
    }
    function storeSettings() { // executed maybe on destruction
        settings.color = root.color
    }
}
```

也可以使用 `category` 属性把设置划分为不同的类别。

```qml
Settings {
    category: 'window'
    property alias x: window.x
    property alias y: window.x
    property alias width: window.width
    property alias height: window.height
}
```

设置会依据你的应用名称、组织名称和域来存储。这些信息通常在 C++ 代码的 main 函数中设置。

```cpp
int main(int argc, char** argv) {
    ...
    QCoreApplication::setApplicationName("Awesome Application");
    QCoreApplication::setOrganizationName("Awesome Company");
    QCoreApplication::setOrganizationDomain("org.awesome");
    ...
}
```

如果你编写的是纯 QML 应用，则可以通过全局属性 `Qt.application.name`、`Qt.application.organization` 和 `Qt.application.domain` 设置同样的信息。
