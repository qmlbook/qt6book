# 管理项目
<a name="managing-projects"></a>

Qt Creator 以项目的形式管理你的源代码。你可以通过 `File ‣ New File or Project` 创建新项目。创建项目时，有许多应用模板可供选择。Qt Creator 能够创建桌面、嵌入式、移动应用程序，甚至能使用 Qt for Python 创建 Python 项目。既有使用 Widgets 或 Qt Quick 的应用模板，也有只用控制台的极简项目模板。对初学者来说很难做出选择，因此我们为你挑出三种项目类型。

* **Other Project / QtQuick UI Prototype**：非常适合用来把玩 QML，因为不涉及 C++ 构建步骤。主要只适合做原型。

* **Applications (Qt Quick) / Qt Quick Application (Empty)**：创建一个带 CMake 支持的极简 C++ 项目，以及用于渲染空窗口的 QML 主文档。这是所有原生 QML 应用的典型默认起点。

* **Libraries / Qt Quick 2.0 Extension Plug-in**：使用此向导为你的 Qt Quick UI 创建插件（plug-in）的桩代码。插件用于以原生元素扩展 Qt Quick。这是创建可复用 Qt Quick 库的理想方式。

* **Applications (Qt) / Qt Widgets Application**：创建使用 Qt Widgets 的桌面应用程序起点。如果你打算开发传统的基于 C++ Widgets 的应用程序，就从这里开始。

* **Applications (Qt) / Qt Console Application**：创建不带任何用户界面的桌面应用程序起点。如果你打算用 Qt C++ 开发传统的 C++ 命令行工具，就从这里开始。


::: tip
在本书的前面几部分，我们主要使用 **QtQuick UI Prototype** 类型或 **Qt Quick Application**，具体取决于是否在 Qt Quick 之外还使用一些 C++ 代码。后面描述 C++ 相关内容时，我们会使用 **Qt Console Application** 类型。要用自己的原生插件扩展 Qt Quick 时，我们使用 *Qt Quick 2.0 Extension Plug-in* 向导类型。
:::
