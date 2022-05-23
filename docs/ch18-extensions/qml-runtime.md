# Understanding the QML Run-time

When running QML, it is being executed inside of a run-time environment. The run-time is implemented in C++ in the `QtQml` module. It consists of an engine, responsible for the execution of QML, contexts, holding global properties accessible for each component, and components - QML elements that can be instantiated from QML.

<<< @/docs/ch18-extensions/src/basicmain/main.cpp

In the example, the `QGuiApplication` encapsulates all that is related to the application instance (e.g. application name, command line arguments and managing the event loop). The `QQmlApplicationEngine` manages the hierarchical order of contexts and components. It requires typical a QML file to be loaded as the starting point of your application. In this case, it is a `main.qml` containing a window and a text type.

::: tip
Loading a `main.qml` with a simple `Item` as the root type through the `QmlApplicationEngine` will not show anything on your display, as it requires a window to manage a surface for rendering. The engine is capable of loading QML code which does not contain any user interface (e.g. plain objects). Because of this, it does not create a window for you by default. The `qml` runtime will internally first check if the main QML file contains a window as a root item and if not create one for you and set the root item as a child to the newly created window.
:::

<<< @/docs/ch18-extensions/src/basicmain/main.qml

In the QML file we declare our dependencies here it is `QtQuick` and `QtQuick.Window`. These declarations will trigger a lookup for these modules in the import paths and on success will load the required plugins by the engine. The newly loaded types will then be made available to the QML environment through a declaration in a a `qmldir` file representing the report.

It is also possible to shortcut the plugin creation by adding our types directly to the engine in our `main.cpp`. Here we assume we have a `CurrentTime`, which is a class based on the `QObject` base class.

```cpp
QQmlApplicationEngine engine();

qmlRegisterType<CurrentTime>("org.example", 1, 0, "CurrentTime");

engine.load(source);
```

Now we can also use the `CurrentTime` type within our QML file.

```qml
import org.example 1.0

CurrentTime {
    // access properties, functions, signals
}
```

If we don't need to be able to instantiate the new class from QML, we can use context properties to expose C++ objects into QML, e.g.

```cpp
QScopedPointer<CurrentTime> current(new CurrentTime());

QQmlApplicationEngine engine();

engine.rootContext().setContextProperty("current", current.value())

engine.load(source);
```

::: tip
Do not mix up `setContextProperty()` and `setProperty()`. The first one sets a context property on a qml context, and `setProperty()` sets a dynamic property value on a `QObject` and will not help you.
:::

Now you can use the current property everywhere in your application. It is available everywhere in the  QML code thanks to context inheritance. The `current` object is registered in the outermost root context, which is inherited everywhere.

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

Here are the different ways you can extend QML in general:

* Context properties - `setContextProperty()`
* Register type with engine - calling `qmlRegisterType` in your `main.cpp`
* QML extension plugins - maximum flexibility, to be discussed next

**Context properties** are easy to use for small applications. They do not require any effort you just expose your system API with kind of global objects. It is helpful to ensure there will be no naming conflicts (e.g. by using a special character for this (`$`) for example `$.currentTime`). `$` is a valid character for JS variables.

**Registering QML types** allows the user to control the lifecycle of a C++ object from QML. This is not possible with the context properties. Also, it does not pollute the global namespace. Still all types need to be registered first and by this, all libraries need to be linked on application start, which in most cases is not really a problem.

The most flexible system is provided by the **QML extension plugins**. They allow you to register types in a plugin which is loaded when the first QML file calls the import identifier. Also by using a QML singleton, there is no need to pollute the global namespace anymore. Plugins allow you to reuse modules across projects, which comes quite handy when you do more than one project with Qt.

Going back to our simple example `main.qml` file:

<<< @/docs/ch18-extensions/src/basicmain/main.qml

When we import the  `QtQuick` and `QtQuick.Window`, what we do is that we tell the QML run-time to find the corresponding QML extension plugins and load them. This is done by the QML engine by looking for these modules in the QML import paths. The newly loaded types will then be made available to the QML environment.

For the remainder of this chapter will focus on the QML extension plugins. As they provide the greatest flexibility and reuse.

