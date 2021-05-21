# Creating the plugin

Qt Creator contains a wizard to create a **QtQuick 2 QML Extension Plugin** we use it to create a plugin called `fileio` with a `FileIO` object to start within the module **“org.example.io”**.

The plugin class is derived from `QQmlExtensionPlugin` and implements the `registerTypes()` function. The `Q_PLUGIN_METADATA`  line is mandatory to identify the plugin as a QML extension plugin. Besides this, there is nothing spectacular going on.

```cpp
#ifndef FILEIO_PLUGIN_H
#define FILEIO_PLUGIN_H

#include <QQmlExtensionPlugin>

class FileioPlugin : public QQmlExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID "org.qt-project.Qt.QQmlExtensionInterface")

public:
    void registerTypes(const char *uri);
};

#endif // FILEIO_PLUGIN_H
```

In the implementation of the `registerTypes` we simply register our `FileIO` class using the `qmlRegisterType` function.

```cpp
#include "fileio_plugin.h"
#include "fileio.h"

#include <qqml.h>

void FileioPlugin::registerTypes(const char *uri)
{
    // @uri org.example.io
    qmlRegisterType<FileIO>(uri, 1, 0, "FileIO");
}
```

Interestingly we cannot see here the module URI (e.g. **org.example.io**). This seems to be set from the outside.

When you look into your project directory you will find a `qmldir` file. This file specifies the content of your QML plugin or better the QML side of your plugin. It should look like this for you.

```cpp
module org.example.io
plugin fileio
```

The module is the URI under which your plugin is reachable by others and the plugin line must be identical with your plugin file name (under mac this would be *libfileio_debug.dylib* on the file system and *fileio* in the *qmldir*). These files are created by Qt Creator based on the given information. The module URI is also available in the .pro file. There is used to build up the install directory.

When you call `make install` in your build folder the library will be copied into the Qt `qml` folder (for Qt 5.4 on mac this would be *“~/Qt/5.4/clang_64/qml”*. The exact path depends on your Qt installation location and the used compiler on your system). There you will find a library inside the “org/example/io” folder. The content are these two files currently

```cpp
libfileio_debug.dylib
qmldir
```

When importing a module called “org.example.io”, the QML engine will look in one of the import paths and tries to locate the “org/example/io” path with a qmldir. The qmldir then will tell the engine which library to load as a QML extension plugin using which module URI. Two modules with the same URI will override each other.

