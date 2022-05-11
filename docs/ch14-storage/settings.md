# Settings

Qt comes with a `Settings` element for loading and storing settings. The is still in the lab’s module, which means the API may break in the future. So be aware.

Here is a small example which applies a color value to a base rectangle. Every time the user clicks on the window a new random color is generated. When the application is closed and relaunched again you should see your last color. The default color should be the color initially set on the root rectangle.

<<< @/docs/ch14-storage/src/colorstore/colorstore.qml#M1

The settings value are stored every time the value changes. This might be not always what you want. To store the settings only when required you can use standard properties combined with a function that alters the setting when called.

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

It is also possible to group settings into different categories using the `category` property.

```qml
Settings {
    category: 'window'
    property alias x: window.x
    property alias y: window.x
    property alias width: window.width
    property alias height: window.height
}
```

The settings are stored according to your application name, organization, and domain. This information is normally set in the main function of your C++ code.

```cpp
int main(int argc, char** argv) {
    ...
    QCoreApplication::setApplicationName("Awesome Application");
    QCoreApplication::setOrganizationName("Awesome Company");
    QCoreApplication::setOrganizationDomain("org.awesome");
    ...
}
```

If you are writing a pure QML application, you can set the same attributed using the global properties `Qt.application.name`, `Qt.application.organization`, and `Qt.application.domain`.
