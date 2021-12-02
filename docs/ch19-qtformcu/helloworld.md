# Hello World - for MCUs

As the setup of Qt for MCU can be a bit tricky, we will start with a _Hello World_ like example to ensure that the toolchain works, and so that we can discuss the basic differences between Qt Quick Ultralite and standard Qt Quick.

First up, we need to start by creating a Qt for MCUs project in Qt Creator to get a C++ entry point into the system. When working with Qt Quick Ultralite, we cannot use a common runtime such as ``qml``. This is because Qt Quick Ultralite is translated into C++ together with optimized versions of all the assets. These are then built into a target executable. This means that there is no support for dynamic loading of QML and such - as there is no interpreter running on the target.

::: warning TODO
TODO screenshot creator project wizard
:::

Once the basic project is setup, replace the QML in ``main.qml`` to the following. We will walk through this example line by line below, but first, build and run it for your _Qt for MCU Desktop_ target. This should result in a window looking like the screenshot below the code.

<<< @/docs/ch19-qtformcu/src/helloworld/main.qml#global

::: warning TODO
* examples of code compatibility: import statements without version numbers.
* https://doc.qt.io/QtForMCUs/qtul-qul-qt-compatibility.html
* javascript support: https://doc.qt.io/QtForMCUs/qtul-javascript-environment.html#using-javascript
* layer support: https://doc.qt.io/QtForMCUs/qtul-improving-performance-with-hardware-layers.html ???
* there are fewer elements, but should be enough to build the typical applications for this type of hardware, e.g. control panels, monitoring uis, etc
:::


::: tip Links
Further reading at qt.io:
* [Qt Quick Ultralite vs Qt Quick](https://doc.qt.io/QtForMCUs/qtul-qtquick-differences.html)
* [Differences between Qt Quick Ultralite Controls and Qt Quick Controls](https://doc.qt.io/QtForMCUs/qtul-qtquick-controls-api-differences.html)
* [Known Issues and Limitations](https://doc.qt.io/QtForMCUs/qtul-known-issues.html)
:::


