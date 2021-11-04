# Creating the plugin

Qt Creator contains a wizard to create a **QtQuick 2 QML Extension Plugin**, found under **Library** when creating a new project. We use it to create a plugin called `fileio` with a `FileIO` object to start within the module `org.example.io`.

::: tip
The current wizard generates a QMake based project. Please use the example from this chapter as a starting point to build a CMake based project. 
:::

The project should consist of the `fileio.h` and `fileio.cpp`, that declare and implement the `FileIO` type, and a `fileio_plugin.cpp` that contains the actual plugin class that allows the QML engine to discover out extension.

The plugin class is derived from the `QQmlEngineExtensionPlugin` class, and contains a the `Q_OBJECT` and `Q_PLUGIN_METADATA` macros. The entire file can be seen below.

<<< @/docs/ch17-extensions/src/fileio/fileio_plugin.cpp

The extension will automatically discover and register all types marked with `QML_ELEMENT` and `QML_NAMED_ELEMENT`. We will see how this is done in the FileIO Implementation section below.

For the import of the module to work, the user also needs to specify a URI, e.g. `import org.example.io`. Interestingly we cannot see the module URI anywhere. This is set from the outside using a `qmldir` file, alternatively in the `CMakeLists.txt` file of your project.

The `qmldir` file specifies the content of your QML plugin or better the QML side of your plugin. A hand-written `qmldir` file for our plugin should look something like this: 

```cpp
module org.example.io
plugin fileio
```

The module is the URI that the user imports, and after it you name which plugin to load for the said URI. The plugin line must be identical with your plugin file name (under mac this would be *libfileio_debug.dylib* on the file system and *fileio* in the *qmldir*, for a Linux system, the same line would look for *libfileio.so*). These files are created by Qt Creator based on the given information. 

The easier way to create a correct `qmldir` file is in the `CMakeLists.txt` for your project, in the `qt_add_qml_module` macro. Here, the `URI` parameter is used to specify the URI of the plugin, e.g. `org.example.io`. This way, the `qmldir` file is generated when the project is built.

::: TODO
How to install the module? 
:::

When importing a module called “org.example.io”, the QML engine will look in one of the import paths and tries to locate the “org/example/io” path with a qmldir. The qmldir then will tell the engine which library to load as a QML extension plugin using which module URI. Two modules with the same URI will override each other.
