# 理解 QML 运行时

QML 是在一个运行时环境（run-time environment）中执行的。该运行时在 `QtQml` 模块中用 C++ 实现，由三部分组成：引擎（engine），负责 QML 的执行；上下文（context），持有可被每个组件访问的全局属性；以及组件（component），即可从 QML 实例化的 QML 元素。

<<< @/docs/ch18-extensions/src/basicmain/main.cpp

在这个示例中，`QGuiApplication` 封装了与应用程序实例相关的所有内容（例如应用程序名称、命令行参数以及事件循环的管理）。`QQmlApplicationEngine` 负责管理上下文与组件的层次顺序。通常它需要加载一个 QML 文件作为应用程序的起点。在本例中，这个文件是 `main.qml`，其中包含一个窗口和一个文本类型。

::: tip
通过 `QmlApplicationEngine` 加载以简单 `Item` 作为根类型的 `main.qml` 时，显示器上不会显示任何内容，因为渲染需要一个窗口来管理绘制表面。引擎能够加载不包含任何用户界面的 QML 代码（例如纯对象）。因此，它默认不会为你创建窗口。`qml` 运行时会在内部先检查主 QML 文件是否包含作为根项的窗口，如果没有，就会为你创建一个窗口，并把根项设置为该新建窗口的子项。
:::

<<< @/docs/ch18-extensions/src/basicmain/main.qml

在这个 QML 文件中，我们声明了自己的依赖，这里是 `QtQuick` 和 `QtQuick.Window`。这些声明会触发引擎在导入路径（import path）中查找这些模块，查找成功后就会加载所需的插件。新加载的类型随后会通过 `qmldir` 文件中的声明提供给 QML 环境，该文件代表相应的模块。

也可以绕过插件创建这一步，直接在 `main.cpp` 中把我们的类型添加到引擎。这里假设我们有一个 `CurrentTime`，它是基于 `QObject` 基类的类。

```cpp
QQmlApplicationEngine engine();

qmlRegisterType<CurrentTime>("org.example", 1, 0, "CurrentTime");

engine.load(source);
```

现在我们也可以在 QML 文件中使用 `CurrentTime` 类型了。

```qml
import org.example 1.0

CurrentTime {
    // access properties, functions, signals
}
```

如果不需要从 QML 实例化这个新类，我们可以使用上下文属性（context property）把 C++ 对象暴露给 QML，例如：

```cpp
QScopedPointer<CurrentTime> current(new CurrentTime());

QQmlApplicationEngine engine();

engine.rootContext().setContextProperty("current", current.value())

engine.load(source);
```

::: tip
不要混淆 `setContextProperty()` 和 `setProperty()`。前者在 QML 上下文上设置上下文属性，而 `setProperty()` 设置的是 `QObject` 上的动态属性值，对你并没有帮助。
:::

现在你可以在应用程序的任何地方使用 current 属性。得益于上下文继承，它在 QML 代码中的任何位置都可用。`current` 对象注册在最外层的根上下文（root context）中，而根上下文会被处处继承。

```qml
import QtQuick
import QtQuick.Window

Window {
    visible: true
    width: 512
    height: 300

    Component.onCompleted: {
        console.log('current: ' + current)
    }
}
```

一般来说，有以下几种扩展 QML 的方式：

* 上下文属性——`setContextProperty()`
* 向引擎注册类型——在 `main.cpp` 中调用 `qmlRegisterType`
* QML 扩展插件——灵活性最高，将在下文讨论

**上下文属性**在小型应用程序中易于使用。它们几乎不需要额外的工作，你只需把系统 API 以类似全局对象的方式暴露出来。最好确保不会出现命名冲突（例如为此使用一个特殊字符（`$`），如 `$.currentTime`）。`$` 是 JavaScript 变量中的合法字符。

**注册 QML 类型**允许用户从 QML 控制 C++ 对象的生命周期。上下文属性做不到这一点。此外，它不会污染全局命名空间。不过所有类型都需要先注册，因此所有库都需要在应用程序启动时链接，不过在大多数情况下这并不是什么问题。

灵活性最高的是 **QML 扩展插件**。它允许你在一个插件中注册类型，该插件会在第一个 QML 文件使用导入标识符时被加载。另外，通过使用 QML 单例（singleton），就不再需要污染全局命名空间了。插件还允许你在不同项目之间复用模块，当你用 Qt 做多个项目时非常方便。

回到我们简单的示例 `main.qml` 文件：

<<< @/docs/ch18-extensions/src/basicmain/main.qml

当我们导入 `QtQuick` 和 `QtQuick.Window` 时，实际上是在告诉 QML 运行时去查找对应的 QML 扩展插件并加载它们。QML 引擎会在 QML 导入路径中查找这些模块来完成这项工作。新加载的类型随后就会对 QML 环境可用。

本章其余部分将聚焦于 QML 扩展插件，因为它们提供了最大的灵活性和复用性。

