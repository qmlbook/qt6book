import QtQuick
import "http://localhost:8080" as Remote

Rectangle {
    width: 320
    height: 320
    color: 'blue'

    Remote.Button {
        anchors.centerIn: parent
        text: 'Quit'
        onClicked: Qt.quit()
    }
}
