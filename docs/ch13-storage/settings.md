# Settings

Qt comes on its native side with the C++ `QSettings` class, which allows you to store the application settings (aka options, preferences) in a system-dependent way. It uses the infrastructure available from your OS. Additional it supports a common INI file format for handling cross-platform settings files.

In Qt 5.2 `Settings` have entered the QML world. The API is still in the lab’s module, which means the API may break in the future. So be aware.

Here is a small example, which applies a color value to a base rectangle. Every time the user clicks on the window a new random color is generated. When the application is closed and relaunched again you should see your last color. The default color should be the color initially set on the root rectangle.

```qml
import QtQuick 2.5
import Qt.labs.settings 1.0

Rectangle {
    id: root
    width: 320; height: 240
    color: '#000000'
    Settings {
        id: settings
        property alias color: root.color
    }
    MouseArea {
        anchors.fill: parent
        onClicked: root.color = Qt.hsla(Math.random(), 0.5, 0.5, 1.0);
    }
}
```

The settings value are stored every time the value changes. This might be not always what you want. To store the settings only when required you can use standard properties.

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

It is also possible to store settings into different categories using the `category` property.

```qml
Settings {
    category: 'window'
    property alias x: window.x
    property alias y: window.x
    property alias width: window.width
    property alias height: window.height
}
```

The settings are stored according to your application name, organization, and domain. This information is normally set in the main function of your c++ code.

```cpp
int main(int argc, char** argv) {
    ...
    QCoreApplication::setApplicationName("Awesome Application");
    QCoreApplication::setOrganizationName("Awesome Company");
    QCoreApplication::setOrganizationDomain("org.awesome");
    ...
}
```

