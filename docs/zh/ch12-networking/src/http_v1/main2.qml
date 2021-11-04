// M1>>
// main2.qml
import QtQuick
import "http://localhost:8080" as Remote

Rectangle {
    width: 320
    height: 320
    color: '#ff0000'

    Remote.Button {
        anchors.centerIn: parent
        text: 'Click Me'
        onClicked: Qt.quit()
    }
}
// <<M1

