# 创建插件

Qt Creator 提供了一个创建 **QtQuick 2 QML Extension Plugin** 的向导，在新建项目时位于 **Library** 下。我们用它创建一个名为 `fileio` 的插件，其中先从模块 `org.example.io` 中的一个 `FileIO` 对象开始。

::: tip
当前向导生成的是基于 QMake 的项目。请使用本章的示例作为起点，来构建基于 CMake 的项目。
:::

该项目应由声明并实现 `FileIO` 类型的 `fileio.h` 和 `fileio.cpp`，以及包含实际插件类的 `fileio_plugin.cpp` 组成，后者让 QML 引擎能够发现我们的扩展。

插件类派生自 `QQmlEngineExtensionPlugin` 类，并包含 `Q_OBJECT` 与 `Q_PLUGIN_METADATA` 宏。整个文件如下所示。

<<< @/docs/ch18-extensions/src/fileio/fileio_plugin.cpp

扩展会自动发现并注册所有标记了 `QML_ELEMENT` 和 `QML_NAMED_ELEMENT` 的类型。我们将在下文的“FileIO 实现”一节中看到这是如何完成的。

要让模块的导入正常工作，用户还需要指定一个 URI，例如 `import org.example.io`。有意思的是，我们在任何地方都看不到模块 URI。它是从外部通过 `qmldir` 文件设置的，也可以在项目的 `CMakeLists.txt` 文件中设置。

`qmldir` 文件规定了 QML 插件的内容，更准确地说，是插件的 QML 侧内容。为我们的插件手写的 `qmldir` 文件大致如下：

```cpp
module org.example.io
plugin fileio
```

module 就是用户导入的 URI，其后你指定为该 URI 加载哪个插件。plugin 行必须与你的插件文件名一致（在 mac 上，文件系统中对应 *libfileio_debug.dylib*，而在 *qmldir* 中写作 *fileio*；在 Linux 系统中，同一行会查找 *libfileio.so*）。这些文件由 Qt Creator 根据给定的信息创建。

更简单地创建正确 `qmldir` 文件的方式，是在项目的 `CMakeLists.txt` 中使用 `qt_add_qml_module` 宏。这里用 `URI` 参数指定插件的 URI，例如 `org.example.io`。这样，`qmldir` 文件会在项目构建时生成。对于这里的示例，`qt_add_qml_module` 宏如下所示：

```
qt_add_qml_module(fileio PLUGIN_TARGET
    VERSION 1.0.0
    URI "org.example.io"
    OUTPUT_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/imports/org/example/io/"
    SOURCES
        fileio.cpp
        fileio.h
        fileio_plugin.cpp
)
```

当导入名为 `org.example.io` 的模块时，QML 引擎会在导入路径中查找（例如 `QML2_IMPORT_PATH` 环境变量），尝试找到带有 `qmldir` 文件的 `org/example/io` 路径。`qmldir` 文件会告诉引擎：使用哪个模块 URI、将哪个库作为 QML 扩展插件加载。具有相同 URI 的两个模块会互相覆盖。对于上面的示例，可以用以下命令导入该模块：

```
QML2_IMPORT_PATH=/home/.../ch18-extensions/src/fileio/imports \
./.../ch18-extensions/src/CityUI/CityUI
```

注意，`QML2_IMPORT_PATH` 指向 `imports` 目录，而 `org/example/io` 子路径是通过导入语句中的 `org.example.io` 部分找到的。
