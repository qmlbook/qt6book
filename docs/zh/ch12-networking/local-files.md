# Local files

Is it also possible to load local (XML/JSON) files using the XMLHttpRequest. For example a local file named “colors.json” can be loaded using:

```js
xhr.open("GET", "colors.json");
```

We use this to read a color table and display it as a grid. It is not possible to modify the file from the Qt Quick side. To store data back to the source we would need a small REST based HTTP server or a native Qt Quick extension for file access.

```qml
import QtQuick

Rectangle {
    width: 360
    height: 360
    color: '#000'

    GridView {
        id: view
        anchors.fill: parent
        cellWidth: width/4
        cellHeight: cellWidth
        delegate: Rectangle {
            width: view.cellWidth
            height: view.cellHeight
            color: modelData.value
        }
    }

    function request() {
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
                print('HEADERS_RECEIVED')
            } else if(xhr.readyState === XMLHttpRequest.DONE) {
                print('DONE');
                var obj = JSON.parse(xhr.responseText.toString());
                view.model = obj.colors
            }
        }
        xhr.open("GET", "colors.json");
        xhr.send();
    }

    Component.onCompleted: {
        request()
    }
}
```

:::tip
For this to work, the `QML_XHR_ALLOW_FILE_READ` must be set and enabled (set to `1`). You can do so by running:

```sh
QML_XHR_ALLOW_FILE_READ=1 qml -f localfiles.qml
```

The issue is when allowing a QML application to read local files through an `XMLHttpRequest`, hence `XHR`, this opens up the entire file system for reading, which is a potential security issue. Qt will allow you to read local files only if the environment variable is set, so that this is a concious decision.
:::




Instead of using the `XMLHttpRequest` it is also possible to use the XmlListModel to access local files.

```qml
import QtQuick
import QtQml.XmlListModel

Rectangle {
    width: 360
    height: 360
    color: '#000'

    GridView {
        id: view
        anchors.fill: parent
        cellWidth: width/4
        cellHeight: cellWidth
        model: xmlModel
        delegate: Rectangle {
            width: view.cellWidth
            height: view.cellHeight
            color: model.value
            Text { 
                anchors.centerIn: parent
                text: model.name
            }
        }
    }

    XmlListModel {
        id: xmlModel
        source: "colors.xml"
        query: "/colors/color"
        XmlListModelRole { name: 'name'; elementName: 'name' }
        XmlListModelRole { name: 'value'; elementName: 'value' }
    }
}
```

With the XmlListModel it is only possible to read XML files and not JSON files.

