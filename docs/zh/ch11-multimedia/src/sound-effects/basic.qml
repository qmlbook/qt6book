import QtQuick
import QtMultimedia

Window {
    width: 300
    height: 200
    visible: true

    SoundEffect {
        id: beep
        source: "file:beep.wav"
    }

    Rectangle {
        id: button

        anchors.centerIn: parent

        width: 200
        height: 100

        color: "red"

        MouseArea {
            anchors.fill: parent
            onClicked: beep.play()
        }
    }
}