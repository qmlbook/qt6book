# Build Systems

Building software reliably across different platforms can be a complex task. You will encounter different environments with different compilers, paths, and library variations. The purpose of Qt is to shield the application developer from these cross-platform issues. Qt relies on [CMake](https://cmake.org/) to convert `CMakeLists.txt` project files to platform specific make files, which then can be built using the platform specific tooling.

::: tip
Qt comes with three different build systems. The original Qt build system 
was called `qmake`. Another Qt specific build system is `QBS` which uses a 
declarative approach to describing the build sequence. Since version 6, Qt 
has shifted from `qmake` to CMake as the official build system.
:::

A typical build flow in Qt under Unix would be:

```sh
vim CMakeLists.txt
cmake . // generates Makefile
make
```

With Qt you are encouraged to use shadow builds. A shadow build is a build outside of your source code location. Assume we have a myproject folder with a `CMakeLists.txt` file. The flow would be like this:

```sh
mkdir build
cd build
cmake ..
```

We create a build folder and then call cmake from inside the build folder with the location of our project folder. This will set up the makefile in a way that all build artifacts are stored under the build folder instead of inside our source code folder. This allows us to create builds for different qt versions and build configurations at the same time and also it does not clutter our source code folder which is always a good thing.

When you are using Qt Creator it does these things behind the scenes for you and you do not have to worry about these steps in most cases. For larger projects and for a deeper understanding of the flow, it is recommended that you learn to build your Qt project from the command line to ensure that you have full control over what is happening.

## CMake

CMake is a tool created by Kitware. Kitware is very well known for their 3D visualization software VTK and also CMake, the cross-platform makefile generator. It uses a series of `CMakeLists.txt` files to generate platform-specific makefiles. CMake is used by the KDE project and as such has a special relationship with the Qt community and since version 6, it is the preferred way to build Qt projects.

The `CMakeLists.txt` is the file used to store the project configuration. For a simple hello world using Qt Core the project file would look like this:

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

This will build a `foundations_tests` executable using `tst_foundation.cpp` and link against the Core and Test libraries from Qt 6. You will find more examples of CMake files in this book, as we use CMake for all C++ based examples.

CMake is a powerful, a complex, tool and it takes some time to get used to the syntax. CMake is very flexible and really shines in large and complex projects.

## References


* [CMake Help](http://www.cmake.org/documentation/) - available online but also as Qt Help format


* [Running CMake](http://www.cmake.org/runningcmake/)


* [KDE CMake Tutorial](https://techbase.kde.org/Development/Tutorials/CMake)


* [CMake Book](http://www.kitware.com/products/books/CMakeBook.html)


* [CMake and Qt](http://www.cmake.org/cmake/help/v3.0/manual/cmake-qt.7.html)


## QMake

QMake is the tool which reads your project file and generates the build file. A project file is a simplified write-down of your project configuration, external dependencies, and your source files. The simplest project file is probably this:

```js
// myproject.pro

SOURCES += main.cpp
```

Here we build an executable application which will have the name `myproject` based on the project file name. The build will only contain the `main.cpp` source file. And by default, we will use the `QtCore` and `QtGui` module for this project. If our project were a QML application we would need to add the `QtQuick` and `QtQml` module to the list:

```js
// myproject.pro

QT += qml quick

SOURCES += main.cpp
```

Now the build file knows to link against the `QtQml` and `QtQuick` Qt modules. QMake uses the concept of `=`, `+=` and `-=` to assign, add, remove elements from a list of options, respectively. For a pure console build without UI dependencies you would remove the `QtGui` module:

```js
// myproject.pro

QT -= gui

SOURCES += main.cpp
```

When you want to build a library instead of an application, you need to change the build template:

```js
// myproject.pro
TEMPLATE = lib

QT -= gui

HEADERS += utils.h
SOURCES += utils.cpp
```

Now the project will build as a library without UI dependencies and used the `utils.h` header and the `utils.cpp` source file. The format of the library will depend on the OS you are building the project.

Often you will have more complicated setups and need to build a set of projects. For this, qmake offers the `subdirs` template. Assume we would have a mylib and a myapp project. Then our setup could be like this:

```js
my.pro
mylib/mylib.pro
mylib/utils.h
mylib/utils.cpp
myapp/myapp.pro
myapp/main.cpp
```

We know already how the mylib.pro and myapp.pro would look like. The my.pro as the overarching project file would look like this:

```js
// my.pro
TEMPLATE = subdirs

subdirs = mylib \
    myapp

myapp.depends = mylib
```

This declares a project with two subprojects: `mylib` and `myapp`, where `myapp` depends on `mylib`. When you run qmake on this project file it will generate file a build file for each project in a corresponding folder. When you run the makefile for `my.pro`, all subprojects are also built.

Sometimes you need to do one thing on one platform and another thing on other platforms based on your configuration. For this qmake introduces the concept of scopes. A scope is applied when a configuration option is set to true.

For example, to use a Unix specific utils implementation you could use:

```js
unix {
    SOURCES += utils_unix.cpp
} else {
    SOURCES += utils.cpp
}
```

What it says is if the CONFIG variable contains a Unix option then apply this scope otherwise use the else path. A typical one is to remove the application bundling under mac:

```js
macx {
    CONFIG -= app_bundle
}
```

This will create your application as a plain executable under mac and not as a `.app` folder which is used for application installation.

QMake based projects are normally the number one choice when you start programming Qt applications. There are also other options out there. All have their benefits and drawbacks. We will shortly discuss these other options next.

## References


* [QMake Manual](http://doc.qt.io/qt-5//qmake-manual.html) - Table of contents of the qmake manual


* [QMake Language](http://doc.qt.io/qt-5//qmake-language.html) - Value assignment, scopes and so like


* [QMake Variables](http://doc.qt.io/qt-5//qmake-variable-reference.html) - Variables like TEMPLATE, CONFIG, QT is explained here
