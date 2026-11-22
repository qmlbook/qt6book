# 构建系统

在不同平台上可靠地构建软件可能是一项复杂的任务。你会遇到不同的环境，它们有着不同的编译器、路径和库变体。Qt 的目标是让应用程序开发者免受这些跨平台问题的困扰。Qt 依赖 [CMake](https://cmake.org/) 将 `CMakeLists.txt` 项目文件转换为平台相关的 make 文件，然后使用平台相关的工具进行构建。

::: tip
Qt 自带三种不同的构建系统。最初的 Qt 构建系统名为 `qmake`。另一个 Qt 专用的构建系统是 `QBS`，它使用声明式的方法来描述构建序列。从版本 6 开始，Qt 已将官方构建系统从 `qmake` 转向 CMake。
:::

在 Unix 下，Qt 中典型的构建流程如下：

```sh
vim CMakeLists.txt
cmake . // generates Makefile
make
```

Qt 鼓励使用影子构建（shadow build）。影子构建是指在源代码位置之外进行构建。假设我们有一个包含 `CMakeLists.txt` 文件的 myproject 文件夹，流程如下：

```sh
mkdir build
cd build
cmake ..
```

我们创建一个 build 文件夹，然后在 build 文件夹内调用 cmake，并给出项目文件夹的位置。这会以如下方式配置 makefile：所有构建产物都存放在 build 文件夹下，而不是源代码文件夹内。这让我们可以同时为不同的 Qt 版本和构建配置创建构建，而且不会弄乱源代码文件夹——这总是一件好事。

当你使用 Qt Creator 时，它会在幕后替你完成这些事情，大多数情况下你不必操心这些步骤。对于较大的项目，以及为了更深入地理解这一流程，建议你学会从命令行构建 Qt 项目，以确保完全掌控正在发生的一切。

## CMake

CMake 是由 Kitware 创建的工具。Kitware 以其 3D 可视化软件 VTK 以及跨平台 makefile 生成器 CMake 而闻名。它使用一系列 `CMakeLists.txt` 文件来生成平台相关的 makefile。CMake 被 KDE 项目使用，因此与 Qt 社区有着特殊的关系；从版本 6 开始，它是构建 Qt 项目的首选方式。

`CMakeLists.txt` 是用来存储项目配置的文件。对于一个使用 Qt Core 的简单 Hello World 程序，项目文件如下所示：

```cmake
// ensure cmake version is at least 3.16.0
cmake_minimum_required(VERSION 3.16.0)

// defines a project with a version
project(foundation_tests VERSION 1.0.0 LANGUAGES CXX)

// pick the C++ standard to use, in this case C++17
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

// tell CMake to run the Qt tools moc, rcc, and uic automatically
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

// configure the Qt 6 modules core and test
find_package(Qt6 COMPONENTS Core REQUIRED)
find_package(Qt6 COMPONENTS Test REQUIRED)

// define an executable built from a source file
add_executable(foundation_tests
    tst_foundation.cpp
)

// tell cmake to link the executable to the Qt 6 core and test modules
target_link_libraries(foundation_tests PRIVATE Qt6::Core Qt6::Test)
```

这将使用 `tst_foundation.cpp` 构建一个 `foundations_tests` 可执行文件，并链接 Qt 6 的 Core 和 Test 库。在本书中你会看到更多 CMake 文件示例，因为我们所有基于 C++ 的示例都使用 CMake。

CMake 是一个强大而复杂的工具，需要一些时间来熟悉其语法。CMake 非常灵活，在大型复杂项目中真正大放异彩。

## 参考资料


* [CMake 帮助](http://www.cmake.org/documentation/) - 可在线获取，也可使用 Qt Help 格式


* [运行 CMake](http://www.cmake.org/runningcmake/)


* [KDE CMake 教程](https://techbase.kde.org/Development/Tutorials/CMake)


* [CMake Book](http://www.kitware.com/products/books/CMakeBook.html)


* [CMake 与 Qt](http://www.cmake.org/cmake/help/v3.0/manual/cmake-qt.7.html)


## QMake

QMake 是读取项目文件并生成构建文件的工具。项目文件是对项目配置、外部依赖和源文件的简化书写。最简单的项目文件大概是这样的：

```js
// myproject.pro

SOURCES += main.cpp
```

这里我们构建一个可执行应用程序，其名称 `myproject` 来自项目文件名。构建中只包含 `main.cpp` 源文件。默认情况下，本项目会使用 `QtCore` 和 `QtGui` 模块。如果我们的项目是一个 QML 应用程序，就需要把 `QtQuick` 和 `QtQml` 模块加入列表：

```js
// myproject.pro

QT += qml quick

SOURCES += main.cpp
```

现在构建文件知道要链接 `QtQml` 和 `QtQuick` 这两个 Qt 模块。QMake 使用 `=`、`+=` 和 `-=` 的概念，分别对选项列表进行赋值、添加和移除元素。对于没有 UI 依赖的纯控制台构建，你可以移除 `QtGui` 模块：

```js
// myproject.pro

QT -= gui

SOURCES += main.cpp
```

当你想构建库而不是应用程序时，需要更改构建模板：

```js
// myproject.pro
TEMPLATE = lib

QT -= gui

HEADERS += utils.h
SOURCES += utils.cpp
```

现在项目将构建为一个没有 UI 依赖的库，并使用 `utils.h` 头文件和 `utils.cpp` 源文件。库的格式取决于你构建项目所用的操作系统。

通常你会有更复杂的设置，需要构建一组项目。为此，qmake 提供了 `subdirs` 模板。假设我们有一个 mylib 项目和一个 myapp 项目，那么我们的设置可能如下：

```js
my.pro
mylib/mylib.pro
mylib/utils.h
mylib/utils.cpp
myapp/myapp.pro
myapp/main.cpp
```

我们已经知道 mylib.pro 和 myapp.pro 会是什么样子。作为总控项目文件的 my.pro 会是这样：

```js
// my.pro
TEMPLATE = subdirs

subdirs = mylib \
    myapp

myapp.depends = mylib
```

这声明了一个包含两个子项目的项目：`mylib` 和 `myapp`，其中 `myapp` 依赖于 `mylib`。当你对这个项目文件运行 qmake 时，它会在相应文件夹中为每个项目生成一个构建文件。当你运行 `my.pro` 的 makefile 时，所有子项目也会被构建。

有时你需要根据配置，在一个平台上做一件事，在其他平台上做另一件事。为此 qmake 引入了作用域（scope）的概念。当某个配置选项被设为 true 时，该作用域就会被应用。

例如，要使用 Unix 专用的 utils 实现，你可以这样写：

```js
unix {
    SOURCES += utils_unix.cpp
} else {
    SOURCES += utils.cpp
}
```

它的意思是：如果 CONFIG 变量包含 Unix 选项，就应用这个作用域，否则走 else 分支。一个典型的例子是在 mac 下移除应用程序打包：

```js
macx {
    CONFIG -= app_bundle
}
```

这会在 mac 下把你的应用程序创建为普通可执行文件，而不是用于安装应用程序的 `.app` 文件夹。

当你开始编写 Qt 应用程序时，基于 QMake 的项目通常是首选。还有其他一些选择，各有优缺点。接下来我们将简要讨论这些其他选项。

## 参考资料


* [QMake 手册](http://doc.qt.io/qt-5//qmake-manual.html) - qmake 手册的目录


* [QMake 语言](http://doc.qt.io/qt-5//qmake-language.html) - 值赋值、作用域等


* [QMake 变量](http://doc.qt.io/qt-5//qmake-variable-reference.html) - 这里解释了 TEMPLATE、CONFIG、QT 等变量
