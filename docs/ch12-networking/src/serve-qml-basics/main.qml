import QtQuick

Loader {
    id: root
    source: 'http://localhost:8080/remote.qml'
    onLoaded: {
        root.width = item.width
        root.height = item.height
    }
}
